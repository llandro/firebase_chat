const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.myFunction = functions.firestore
  .document('chats/uNeOQeyog8rkqByMUYNw/messages/{message}')
  .onCreate((snapshot, context) => {
         console.log(snapshot.data());
         return admin.messaging().sendToTopic('chat', {
            notification: {
                title: snapshot.data().userName,
                body: snapshot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
               },
            });


   });