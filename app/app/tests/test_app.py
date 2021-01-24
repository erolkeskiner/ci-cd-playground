def test_welcome(app, client):
    res = client.get('/')
    assert res.status_code == 200
    expected = 'Greetings to the World!'
    assert expected == res.get_data(as_text=True)


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


def test_readiness_probe(app, client):
    res = client.get('/healthz/ready')
    assert res.status_code == 200
    expected = 'OK\n'
    assert expected == res.get_data(as_text=True)


def test_liveness_probe(app, client):
    res = client.get('/healthz/live')
    assert res.status_code == 200
    expected = 'OK\n'
    assert expected == res.get_data(as_text=True)
