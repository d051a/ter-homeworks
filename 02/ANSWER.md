#### Задание #1

исправленные ошибки в процессе запуска:
```
│ Error: Error while requesting API to create network: server-request-id ... Quota limit vpc.networks.count exceeded ... resource "yandex_vpc_network" "develop" {
```
ограничение yandex-cloud на количество сетей

```
│ Error: No value for required variable ...
│    2: variable "token" {
```
не было заданного значения у переменной

```
│ Error: Invalid function argument ... 
service_account_key_file = file("~/.authorized_key.json")
```
не было файла с ключом


```
│ Error: Error while requesting API to create instance: server-request-id ...Platform "standart-v4" not found
```
нет платформы с таким названием yandex-cloud


```
 Error: Error while requesting API to create instance: server-request-id = allowed core number: 2, 4
```
в yandex-cloud количество ядер у instance не может быть == 1


Итоговый результат:
![ответ #1](./answer1.png)
![ответ #2](./answer2.png)


#### Задания #1-6

Ответ в директории ./src

#### Задания #7

```
local.test_list[1]
```


```
length(local.test_list)
```


```
local.test_map["admin"]
```



#### Задания #8
```
var.test[0]["dev1"][0]
```

