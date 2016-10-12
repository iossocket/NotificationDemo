# NotificationDemo
iOS10 Notification


* Here we can use houston to create a notification:
```
apn push "device token" -c ./apple_push_notification.pem -P '{"aps":{"alert":{"title":"This is title","subtitle":"this is subtitle","body":"this is body"},"sound":"default","badge":1}}'
```

* When you want to use Notification Service Extension
```
apn push "device token" -c ./apple_push_notification.pem -P '{"aps":{"alert":"New Message Available","sound":"default","badge":1,"mutable-content":1},"encrypted-content":"#myencrypedcontent"}'
```

* For iOS 9, we can use:
```
apn push "device token" -c ./apple_push_notification.pem -P '{"aps":{"alert":"You’re invited!","sound":"default","badge":1,"category":"INVITE_CATEGORY"}}'
```

* Use NotificationService:
```
apn push "device token" -c ./apple_push_notification.pem -P '{"aps":{"alert":"New Message Available","sound":"default","badge":1,"mutable-content":1},"encrypted-content":"#myencrypedcontent"}'
```