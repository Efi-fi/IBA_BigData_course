def main(dict):
	import requests
	currency = dict['currency'] if 'currency' in dict else 'USD'
	url = f'https://www.nbrb.by/api/exrates/rates/{currency}?parammode=2'
	resp = requests.get(url).json()
	print(resp)
	return resp['Cur_OfficialRate']


if __name__ == '__main__':
	main({"currency": "EUR"})