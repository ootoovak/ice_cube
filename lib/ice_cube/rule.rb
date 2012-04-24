require 'yaml'

module IceCube

  class Rule

    attr_reader :uses

    # Is this a terminating schedule?
    def terminating?
      until_time || occurrence_count
    end

    def ==(rule)
      if rule.is_a? Rule
        hash = to_hash
        hash && hash == rule.to_hash
      end
    end

    def hash
      h = to_hash
      h.nil? ? super : h.hash
    end

    # Expected to be overridden by subclasses
    def to_ical
      nil
    end

    # Yaml implementation
    def to_yaml(*args)
      IceCube::use_psych? ? Psych::dump(to_hash) : YAML::dump(to_hash, *args)
    end

    # From yaml
    def self.from_yaml(yaml)
      from_hash IceCube::use_psych? ? Psych::load(yaml) : YAML::load(yaml)
    end

    # Expected to be overridden by subclasses
    def to_hash
      nil
    end

    # Convert from a hash and create a rule
    def self.from_hash(hash, before_utc = false)
      return nil unless match = hash[:rule_type].match(/\:\:(.+?)Rule/)

      rule = IceCube::Rule.send(match[1].downcase.to_sym, hash[:interval] || 1)
      rule.until(TimeUtil.deserialize_time(hash[:until])) if hash[:until]
      rule.count(hash[:count]) if hash[:count]

      hash[:validations] && hash[:validations].each do |key, value|
        # Convert the days back into current timezone as needed
        if before_utc && (key == :day)
          value = value.map { |v| (v + 1) % 7 }
        elsif before_utc && (key == :day_of_week)
          value = value.inject({}) { |nv, (k, v)| nv[(k + 1) % 7] = v; nv }
        end

        key = key.to_sym unless key.is_a?(Symbol)
        value.is_a?(Array) ? rule.send(key, *value) : rule.send(key, value)
      end

      return rule
    end

    # Reset the uses on the rule to 0
    def reset
      @uses = 0
    end

    def next_time(time, schedule, closing_time)
    end

    def on?(time, schedule)
      next_time(time, schedule, time) == time
    end

    # Whether this rule requires a full run
    def full_required?
      !@count.nil?
    end

    # Convenience methods for creating Rules
    class << self

      # Secondly Rule
      def secondly(interval = 1)
        SecondlyRule.new(interval)
      end

      # Minutely Rule
      def minutely(interval = 1)
        MinutelyRule.new(interval)
      end

      # Hourly Rule
      def hourly(interval = 1)
        HourlyRule.new(interval)
      end

      # Daily Rule
      def daily(interval = 1)
        DailyRule.new(interval)
      end

      # Weekly Rule
      def weekly(interval = 1, week_start = :sunday)
        WeeklyRule.new(interval, week_start)
      end

      # Monthly Rule
      def monthly(interval = 1)
        MonthlyRule.new(interval)
      end

      # Yearly Rule
      def yearly(interval = 1)
        YearlyRule.new(interval)
      end

    end
    
  end

end
