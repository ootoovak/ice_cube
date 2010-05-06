### Persistence

ice_cube offers a hash-backed to_yaml implementation, making it super easy (and safe) to serialize schedule objects to your data store:

{% highlight ruby %}
# YAML
yaml = schedule.to_yaml
schedule = Schedule.from_yaml(yaml)

# Hash
hash = schedule.to_hash
schedule = Schedule.from_hash(hash)
{% endhighlight %}