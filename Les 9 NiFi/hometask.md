### Установка Docker
Linux: https://docs.docker.com/engine/install/#server
Windows: https://docs.docker.com/docker-for-windows/install/
Mac: https://docs.docker.com/docker-for-mac/install/

### Подготовка NiFi сервиса

1. `docker pull apache/nifi`
2. `docker run -p 8000:8080 -d --name nifi apache/nifi`
3. Подождать пару минут
4. Зайти в браузер и перейти по ссылке: <http://localhost:8000/nifi>

### Задание по NiFi:
1. С [сайта](https://openweathermap.org/current) получать текущую температуру для любого выбранного вами города
2. Получать данные каждую минуту, и складывать в папку /opt/nifi/nifi-current/wheater_per_minute
3. Придумать логику, чтобы в 00:00, каждый день, забирались все полученные данные за день и агрегировались в один файл
4. Выходной файл должен быть в формате csv со следующей структурой строк:
<datetime>,<temperature_in_celsius>
5. Сохранить полученный файл нужно в папку /opt/nifi/nifi-current/wheater_per_day, с названием файла <date>_<city>.csv