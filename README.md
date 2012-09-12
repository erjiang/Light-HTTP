Light-HTTP
==========
A simple, light weight, HTTP requester

# How to use

```objc
HTTPRequest *request = [[HTTPRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
[request addParameterWithKey:@"count" value:[NSString stringWithFormat:@"%d", count]];
[request addParameterWithKey:@"skip" value:[NSString stringWithFormat:@"%d", skip]];
[request addTarget:self action:@selector(targetWhenRequestFinished:) forEvent:HTTPRequestEventDidFinishLoading];
[request addTarget:self action:@selector(tartgetWhenRequestStarted:) forEvent:HTTPRequestEventDidStartLoading];
[[HTTPRequester sharedInstance] getRequest:request];
```

