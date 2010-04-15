### The full workflow, what's in a Schedule?

{% highlight ruby %}
# Create a schedule for every day in May
schedule = Schedule.new(Time.now)
schedule.add_recurrence_rule Rule.daily.month_of_year(:may)

# Does it occur at a certain time?
schedule.occurs_at?(Time.local(2010, 11, 1)) # false

# Does it occur on a certain date?
schedule.occurs_on?(Date.today)

# All of the occurrences between two Times
schedule.occurrences_between(Time.local(2010, 1, 1), Time.local(2010, 12, 1))

# When are the first 10 occurrences
schedule.first(10) # [Thu May 13 18:01:46 -0400 2010, Fri May 13 ...]

# All of the occurrences between now and another Time
schedule.occurrences(Time.local(2010, 12, 1)) # [Thu May 13 18:01:46 -0400 2010]
{% endhighlight %}