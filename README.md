THIS IS A FORK OF https://github.com/igrigorik/bloomfilter-rb

# BloomFilter(s) in Ruby

- Redis-backed getbit/setbit non-counting bloom filter
- Redis-backed set-based counting (+TTL) bloom filter

Bloom filter is a space-efficient probabilistic data structure that is used to test whether an element is a member of a set. False positives are possible, but false negatives are not. For more detail, check the [wikipedia article](http://en.wikipedia.org/wiki/Bloom_filter). Instead of using k different hash functions, this implementation seeds the CRC32 hash with k different initial values (0, 1, ..., k-1). This may or may not give you a good distribution, it all depends on the data.

Performance of the Bloom filter depends on a number of variables:

- size of the bit array
- size of the counter bucket
- number of hash functions

## Resources

- Determining parameters: [Scalable Datasets: Bloom Filters in Ruby](http://www.igvita.com/2008/12/27/scalable-datasets-bloom-filters-in-ruby/)
- Applications & reasons behind bloom filter: [Flow analysis: Time based bloom filter](http://www.igvita.com/2010/01/06/flow-analysis-time-based-bloom-filters/)

***

## Redis-backed setbit/getbit bloom filter

Uses [getbit](http://redis.io/commands/getbit)/[setbit](http://redis.io/commands/setbit) on Redis strings - efficient, fast, can be shared by multiple/concurrent processes.

```ruby
bf = BloomFilter::Redis.new

bf.insert('test')
bf.include?('test')     # => true
bf.include?('blah')     # => false

bf.delete('test')
bf.include?('test')     # => false
```

### Memory footprint

- 1.0% error rate for 1M items, 10 bits/item: *2.5 mb*
- 1.0% error rate for 150M items, 10 bits per item: *358.52 mb*
- 0.1% error rate for 150M items, 15 bits per item: *537.33 mb*

***

## Redis-backed counting bloom filter with TTL's
Uses regular Redis get/set counters to implement a counting filter with optional TTL expiry. Because each "bit" requires its own key in Redis, you do incur a much larger memory overhead.

```ruby
bf = BloomFilter::CountingRedis.new(:ttl => 2)

bf.insert('test')
bf.include?('test')     # => true

sleep(2)
bf.include?('test')     # => false
```

## Credits

Tatsuya Mori <valdzone@gmail.com> (Original C implementation: http://vald.x0.com/sb/)

## License

MIT License - Copyright (c) 2011 Ilya Grigorik
