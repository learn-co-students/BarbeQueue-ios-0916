---
tags: CS, datastructures, queue, programmatic views, delegates
languages: objc
---

# BarbeQueue

We're going to have a barbecue for all of our Flatiron friends! Let's come up a list of ingredients so we'll know what we're shopping for. Our app is going to send our list to the cloud so our friends can look and make themselves useful by buying different stuff.

Since we're adding ingredients to this list one-by-one, let's send the new ingredient to the server whenever one is added. 

__BUT WAIT!__

What happens when we don't have connectivity!? Well, we can have local data (ingredients) in our tableivew that doesn't make it to the cloud.

What can we do about this? One option is to keep track of the requests we're trying to make to the server using a `queue`.

A queue is an ordered list that you can only at the end of (enqueue) and that you can only remove from the beginning of the list (dequeue). This means that a queue follows a FIFO, or First In First Out, policy. Just like when we wait on line for some Shake Shack, the first person in line is the first person served.

With our queue, we can `enqueue` ingredient internet requests (keeping our original order, first in/first out), call `peek` on the queue to get the first request in line without removing it from the queue, try sending the request, and `dequeue` the successful request or leave the failed request at the front of the queue.

Wikipedia has a great article on queues as a computer science data structure:
[Queues on Wikipedia](http://en.wikipedia.org/wiki/Queue_(abstract_data_type))

## Instructions

Build out the FISRequestQueue in the BarbeQueue project. These are the methods it should respond to:

```objc
- (BOOL)isEmpty; // returns YES if the queue is empty, NO otherwise
- (void)enqueue:(id)anObject; // adds an object to the end of the queue
- (id)dequeue; // removes and returns the next object in the queue
- (NSUInteger)size; // returns the size of the queue
- (id)peek; // returns the next object in the queue without removing it
```

Make sure the tests pass!

Once you're done, run (don't test) the project. You should be able to add ingredients to our BBQ Ingredients tableview. Now turn on the Network Link Conditioner and change the profile to 100% Loss. Add more ingredients.

You should see that the ingredients you added before turning on the Network Link Conditioner should say `Pending Write: NO`, and the ones added after will say `Pending Write: YES`. These ingredients are telling you that they have not successfully hit the server. Turn off the Network Link Conditioner and hit the refresh button on the left side of the nav bar. 
