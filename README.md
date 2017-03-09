# Bin packing problem interface
Once upon a time, in a faraway land, lived a young programmer who had to deal with a big problem, he had to make a tech solution for a furniture store which needed to know how much material they had to use for build each piece of furniture based on a custom size that each customer could ask for. Some of these pieces could be rotated while others could not.

So this young programmer started creating a math solution to solve this out, but then he figured out that at that moment he sucked in math, at least he sucked in math enough to don't be able to do that on his own.

Well, if you haven't figured out I'm talking about myself here yet, I'm going to give you a clue: I'm talking about myself here.

So, I found out this library: [ruby-binpack](https://github.com/kreynolds/ruby-binpack) by @kreynolds where he built a really smart method to resolve this problem. I just adjusted it a little bit (you are going to figure it out looking at the code).

These customers needed a simple way to check that this code worked as they expected to work, so I created this ugly, error prone but functional interface to show them easily that it worked pretty well.

Just to be clear, the interface is not the only thing ugly here, the code is fucking horrible, it doesn't respect a correct MVC pattern and it was written as quick as possible (I'm serious, I wrote this shit being in a meeting while my co-worker was talking to the customers). Once I finish that meeting I thought this could be helpful for someone else and I made this repository.

Some screenshots:
![image](https://cloud.githubusercontent.com/assets/16837996/23754679/a297bbf6-04bc-11e7-8a90-cc406f2cfca1.png)

![image](https://cloud.githubusercontent.com/assets/16837996/23754685/a6e5bdf2-04bc-11e7-9438-993b92093650.png)
