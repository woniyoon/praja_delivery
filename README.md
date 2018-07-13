# praja_delivery

<img width="150" alt="logo" src="https://user-images.githubusercontent.com/33106403/42664604-7760a716-85f0-11e8-9b8b-d8d947910149.png">

An iOS App for Grocery Shopping


<img width="500" alt="main" src="https://user-images.githubusercontent.com/33106403/42664605-7774994c-85f0-11e8-9b3f-a98da1151d5d.png">

## Introduction
- This is an iOS app created as a team project in the school. My team decided to develop a grocery shopping application using Swift in Xcode. Nobody had any experience in terms of iOS development. We've spent approximately 5 months including brainstorming, making a wireframe, UI/UX design and coding. My team consisted of the followings in alphabetical order :

  __Bruno__ : Project manager

  __Diego__ : Backend (Stripe)
  
  __Jaewon(me)__ : Backend
  
  __Kento__ : Tech Lead
  
  __Mai__ : Designer


## Tools We Used

<p float="left">
  <img src="https://cdn0.iconfinder.com/data/icons/social-network-24/512/Trello-512.png" width=100 height=100 hspace="10"/> 
  <img src="https://cdn3.iconfinder.com/data/icons/social-network-30/512/social-08-512.png" width=80 height=80 hspace="10"/>
  <img src="http://www.iconarchive.com/download/i105729/papirus-team/papirus-apps/google-docs.ico" width=90 height=90 hspace="10"/>
</p>

- __Trello__ to manage the project
- __Slack__ to communicate, share some tips, update with a progress and chit-chat :)
- __Google SpreadSheet__ to visualize data structure, which is more appropriate for NoSQL DB. We also updated our master data through script 


## Frameworks We Used

<p float="left">
  <img src="https://avatars0.githubusercontent.com/u/13637225?v=3&s=600" width=80 height=80 hspace="20"/>
  <img src="https://koenig-media.raywenderlich.com/uploads/2016/07/Rx_Logo_M.png" width=80 height=80 hspace="20"/>
</p>

- __Swinject__ for Dependency Injection
- __RxSwift__ for Reactive Programming


## Database We Used

<p float="left">
  <img src="https://img.stackshare.io/service/4577/realm_logo_200_x_200.png" width=90 height=90 hspace="20"/>
  <img src="https://d1qb2nb5cznatu.cloudfront.net/startups/i/13274-1e708e28fa58694493de9b2f3bf08a11-medium_jpg.jpg?buster=1474899541" width=100 height=100 hspace="20"/>
</p>

- __Realm DB__ as a mobile DB
- __Firebase(Cloud FireStore)__ for a Serverless App


## Payment Library

<img src="https://stripe.com/img/about/logos/logos/blue@2x.png" width=150 height=55>

- __Stripe__

## Architecture We Used

- __MVVM__


## More About My Tasks
 
 <img width="500" alt="jaewon design" src="https://user-images.githubusercontent.com/33106403/42664736-28290ed0-85f1-11e8-8a55-21783ee391d9.png">

- I contributed to make a wireframe as well as design even though my design wasn't fully adopted. I used Sketch.
- I did a research about using multiple Storyboards to avoid having many conflicts and applied it to our project.
- I worked on __Home__/__SignIn__/__Account__/__Checkout__ screens. 
- I tried to use RxDatasources to implement UICollectionView using RxSwift, which was one of the most challenging tasks.
- I made an effort to define data structure and dabbled in google apps script.
- I devoted myself to help the others whenever they need.
- I sometimes led a daily meeting when our project manager was absent.


## How it looks like?


![home](https://user-images.githubusercontent.com/33106403/42664602-7730bb1e-85f0-11e8-8677-f5f4c67220e6.gif)


- This is the first screen of the application, you can scroll up and down, check items and see the detail of an item.
  We decided to use Tabbar so that a user can easily check its order history and its account.




![category](https://user-images.githubusercontent.com/33106403/42664600-771b7e7a-85f0-11e8-98d9-98bda31f63fd.gif)
- It leads you to Category list by tapping on the button on the top left side on Home screen. This gif shows the transition
  from Category list to Product Detail page.

![login](https://user-images.githubusercontent.com/33106403/42664603-7743fd32-85f0-11e8-8ca2-2a50419ffcc9.gif)
- We used Firebase Authentication API, with which user can sign up, sign in and reset a password. This gif describes the progress of sign-in and account page.

![makeorder](https://user-images.githubusercontent.com/33106403/42665313-f2819952-85f3-11e8-9bc3-9b9926f76b8b.gif)
- This gif illustrates adding products, editing the amount, choosing an address from the registered ones, and making a payment through Stripe.


## After The Project

- From the beginning of the project I had been excited to work on this project since it'd be my first team project ever. 
In fact, our team had a lot of difficulties from A to Z, it was obviously challenging enough to make all of us frustrated.
Each of us was so new to Swift and Xcode, on top of that, we decided to use MVVM architecture and RxSwift together, which later turned out
it was so difficult to find some references or material introducing both of them. (Also it was really hard to use Stripe) However, we never gave it up and never stopped
googling and experimenting, finally we were able to finish it!
- I truly admit that the 6 months of work were tough and the project itself is not perfectly flawlessly. But I have a big affection
for this project. Through this project I've learned how an app development proceeds and how a team should work beside coding skill itself.
I couldn't make it without my teammates, who bore with my lack of knowledge and were always only one call away to help one another.
