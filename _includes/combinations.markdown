### Combining Rules

Multiple validations on the same rule, result in an AND (&&) relationship

{% highlight ruby %}
# On Wednesdays THAT ARE ALSO in April
schedule.add_recurrence_rule Rule.weekly.day(:wednesday).month_of_year(:april)
{% endhighlight %}

Multiple rules in the same schedule, result in an OR (||) relationship

{% highlight ruby %}
# On Thursdays and the 100th day of the year
schedule.add_recurrence_rule Rule.weekly.day(:thursday)
schedule.add_recurrence_rule Rule.day_of_year(100)
{% endhighlight %}