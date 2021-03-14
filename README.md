# docker-scratch-rust
A sample docker image from scratch, i.e. without a fully fledged Linux OS included.  

It produces a 3.79MB image that does just this! To build it, just clone this repo and run:
```bash
./build.sh
```

## Learnings
Even with rust, building a statically linked library isn't as simple as just telling the compiler & linker that you want it to be static. The dependencies on libc means that by default everything is dynamically linked. This is because most of the time in linux the implementation of libc will be glibc and that can't be statically linked. This is why almost all rust docker images will depend on Alpine as their base image with glibc included.

The answer to this problem is [musl](http://musl.libc.org/), an implementation of libc that *can* be statically linked. As we're building in docker, we don't even need to do the installation and setup ourselves and can make use of other people's hard work by compiling within [rust-musl-builder](https://github.com/emk/rust-musl-builder).

## Conclusion
Building an image from scratch was an interesting excercise and was relatively quick and pain-free for this *very* small sample project. But even here it would have saved me ~1hr to just base from alpine for the runtime image. 

For security-focussed images there may be an interesting advantage to basing from scratch in that you reduce your attack surface to near-zero (beyond your own application!), but for many the additional complexity of building a statically linked executable (or bringing in all of the external dependencies, which would then increase the attack surface again...) probably isn't worth the bother.