# NotificationDemo
iOS10 Notification

Here we can use houston to create a notification:
```
apn push "device token" -c ./apple_push_notification.pem -P '{"aps":{"alert":{"title":"This is title","subtitle":"this is subtitle","body":"this is body"},"sound":"default","badge":1}}'
```

