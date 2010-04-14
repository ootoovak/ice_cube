### Using your words

{% highlight ruby %}
# A complex rule
rule = Rule.daily.day_of_week(:monday => [1, -1]).month_of_year(:april)

rule.to_s # Daily in April on the last and 1st Mondays
rule.to_ical # FREQ=DAILY;BYMONTH=4;BYDAY=-1MO,1MO
rule.to_yaml # :rrules: \n- :until: \n :count: ...
{% endhighlight %}