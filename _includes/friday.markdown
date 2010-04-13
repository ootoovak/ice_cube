### Complex Rules, Simple.

{% highlight ruby %}
# The fridays in October that is the 13th of the month
Rule.weekly.day(:friday).day_of_month(13).month_of_year(:october)
{% endhighlight %}