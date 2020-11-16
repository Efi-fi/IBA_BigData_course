## 1. Написать свой range, если не указана верхняя граница, то до бесконечности
```
def sign(x): # определение знака числа
	if x > 0:
		return 1
	elif x == 0:
		return 0
	else:
		return -1


class eiterator: # итератор
	def __init__(self, iter_obj):
		self.iter_obj = iter_obj

	def __next__(self):
		if not self.iter_obj.run:
			raise StopIteration
		elif self.iter_obj.pos_2:
			if sign(self.iter_obj.pos_2 - self.iter_obj.curr_value - self.iter_obj.step) != sign(self.iter_obj.step):
				raise StopIteration
			else:
				self.iter_obj.curr_value += self.iter_obj.step
		else:
			self.iter_obj.curr_value += self.iter_obj.step

		return self.iter_obj.curr_value


class erange: # итерируемый объект
	def __init__(self, pos_1=None, pos_2=None, step=None):
		self.pos_1 = pos_1
		self.pos_2 = pos_2
		self.step = step

		if not pos_1 or not pos_2:
			self.pos_1 = 0
			if pos_1:
				self.pos_2 = pos_1

		self.run =True
		if self.pos_2:
			self.diff = self.pos_2 - self.pos_1
			if self.step:
				if sign(self.diff) != sign(self.step):
					self.run = False
			else:
				self.step = sign(self.diff)

		if not self.step:
			self.step = 1



		if self.run:
			self.curr_value = self.pos_1 - self.step


	def __iter__(self):
		return eiterator(self)
```
### erange(x1, x2, step) -- итерируемый объект
*	pos_1 -- начало [опционально], по умолчанию 0 
*	pos_2 -- конец [опционально], по умолчанию бесконечность (pos_1, если pos_2 не указано)
*	step -- шаг [опционально], по умолчанию 1(-1 если pos_2 < pos_1)

```
for i in erange():
	print(i)
```
Выведет 0, 1, 2 ... до бесконечности

## 2. По номеру билета определить, является ли он счастливым.
### Номер билетика содержит четное количество цифр.
### Билетик является счастливым, если сумма первой половины цифр равна второй половине.

```
#def sum_digs(digs_list):
#	return sum(map(int, digs_list)) # Сумма цифр в списке цифр


def lucky_ticket(number):
	digs = list(str(number))
	sum_digs = lambda digs_list: sum(map(int, digs_list))
	begin, end = sum_digs(digs[:len(digs)//2]) , sum_digs(digs[len(digs)//2:])
	return begin == end
```