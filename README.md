#  SwiftUI Drag and Drop Example

This very basic example shows how to implement non-trivial Drag and Drop. It
currently only shows that attempting to accept multiple drops from Photos crashes.

To reproduce:

1. Run the project from Xcode
2. Grab two or more images from Photos and drag them to the red target area
3. This example will crash with an assert in Apple code, but *after* it calls
	the drop handler.

```
*** Assertion failure in -[NSFilePromiseReceiver receivePromisedFilesAtDestination:options:operationQueue:reader:], NSFilePromiseReceiver.m:349

*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Could not get filename from URL:'
*** First throw call stack:
(
	0   CoreFoundation                      0x000000018b6d0570 __exceptionPreprocess + 176
	1   libobjc.A.dylib                     0x000000018b1c1eb4 objc_exception_throw + 60
	2   Foundation                          0x000000018c81843c -[NSCalendarDate initWithCoder:] + 0
	3   AppKit                              0x000000018fa59848 -[NSFilePromiseReceiver receivePromisedFilesAtDestination:options:operationQueue:reader:] + 1080
	4   SwiftUI                             0x00000001b702f798 OUTLINED_FUNCTION_20 + 25756
	5   SwiftUI                             0x00000001b728c238 OUTLINED_FUNCTION_10 + 9348
	6   Foundation                          0x000000018c746c14 __NSBLOCKOPERATION_IS_CALLING_OUT_TO_A_BLOCK__ + 24
	7   Foundation                          0x000000018c746ad4 -[NSBlockOperation main] + 104
	8   Foundation                          0x000000018c746a64 __NSOPERATION_IS_INVOKING_MAIN__ + 16
	9   Foundation                          0x000000018c745e0c -[NSOperation start] + 648
	10  Foundation                          0x000000018c745b7c __NSOPERATIONQUEUE_IS_STARTING_AN_OPERATION__ + 16
	11  Foundation                          0x000000018c745a6c __NSOQSchedule_f + 172
	12  libdispatch.dylib                   0x000000010473a9d0 _dispatch_block_async_invoke2 + 148
	13  libdispatch.dylib                   0x0000000104726b4c _dispatch_client_callout + 20
	14  libdispatch.dylib                   0x000000010472a39c _dispatch_continuation_pop + 704
	15  libdispatch.dylib                   0x000000010472931c _dispatch_async_redirect_invoke + 620
	16  libdispatch.dylib                   0x000000010473e8e4 _dispatch_root_queue_drain + 404
	17  libdispatch.dylib                   0x000000010473f4f4 _dispatch_worker_thread2 + 188
	18  libsystem_pthread.dylib             0x00000001047cfd60 _pthread_wqthread + 228
	19  libsystem_pthread.dylib             0x00000001047d7ab4 start_wqthread + 8
)
```

The code in question starts at `ContentView.swift:22`. You can play with the various `#if` to
try different variations of how to accept drops.
