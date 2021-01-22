def test_without_url_parameter(app, client):
    res = client.get('/helloworld')
    assert res.status_code == 200
    expected = 'Hello Stranger!'
    assert expected == res.get_data(as_text=True)


def test_with_url_parameter(app, client):
    res = client.get('/helloworld?name=SomeName')
    assert res.status_code == 200
    expected = 'Hello SomeName!'
    assert expected == res.get_data(as_text=True)
