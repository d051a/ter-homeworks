#### 2. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
- Согласно указанному .gitignore, личную и секретную информацию можно хранить в файлах с расширением .auto.tfvars и в файле personal.auto.tfvars

#### 3. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

Error: Missing name for resource - пропущено название ресурса
Error: Invalid resource name - недопустимое название ресурса (начинается с числа 1)
Error: Reference to undeclared resource - необъявленный ресурс random_string_FAKE
Error: Unsupported attribute - неподдерживаемый атрибут resulT


#### 4. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```

#### 5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```
```
➜  src git:(main) ✗ docker ps                     
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
d811053610a4   0469e929ca63   "/docker-entrypoint.…"   9 seconds ago   Up 8 seconds   0.0.0.0:9090->80/tcp   example_qTb2g6t9Hw9x2QMn
```

#### 6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.

Когда может пригодиться ключ -auto-approve
CI/CD: В контексте автоматизации и использования CI/CD пайплайнов, где все изменения тщательно протестированы и подтверждены, использование -auto-approve позволяет автоматизировать процесс развертывания без необходимости ручного вмешательства.

Тестовые окружения: При работе с тестовыми или локальными окружениями, где последствия ошибок не так критичны, -auto-approve помогает сэкономить время на подтверждение изменений.

```
➜  src git:(main) ✗ docker ps                    
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
88297918e618   0469e929ca63   "/docker-entrypoint.…"   2 seconds ago   Up 2 seconds   0.0.0.0:9090->80/tcp   hello_world_FPlyOeZBnwOuS9y3
```

#### 8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
```
{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 49,
  "lineage": "cd0435e0-7d3c-1aed-5e4c-a28f20b55fbb",
  "outputs": {},
  "resources": [],
  "check_results": null
}

```


#### 9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**.
```
keep_locally = true
```
Эта строка указывает Terraform сохранить Docker-образ локально даже после того, как он перестанет использоваться контейнером.

Подтверждение из документации Terraform провайдера Docker:

keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.