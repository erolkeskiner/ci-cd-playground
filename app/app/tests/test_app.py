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
    expected = 'Hello Some Name!'
    assert expected == res.get_data(as_text=True)
    res = client.get('/helloworld?name=SomeOtherName')
    assert res.status_code == 200
    expected = 'Hello Some Other Name!'
    assert expected == res.get_data(as_text=True)
    res = client.get('/helloworld?name=someOtherName')
    assert res.status_code == 200
    expected = 'Hello some Other Name!'
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


def test_versionz(app, client):
    import json
    res = client.get('/versionz')
    assert res.status_code == 200
    response_data = json.loads(res.get_data(as_text=True))
    assert 'info' in response_data
    assert 'request_query_time' in response_data
