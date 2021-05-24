# frozen_string_literal: true

Doorkeeper::OpenidConnect.configure do
  issuer do |resource_owner, application|
    'http://localhost:3000/'
  end

  signing_key <<~KEY
    -----BEGIN RSA PRIVATE KEY-----
    MIIEpQIBAAKCAQEA3x9ZSZ0wgYQ7DKnloWck3oJKygmHgblATf9nVejpmPX267c2
    bdc6+vpFoarLSYbcaJmEkZnlQN9MyFB+2hsbbY2fWsMSpbf3eP9sgdWDSsqGiIDp
    UnOWAzjfeTd+R7n+N7JcR/BIBxNBeoRva9zlWcFfBsImTSR60fj1PP4ONawWt5zT
    0VpeCQQUBxUodUSyEg3TSJHZypefsAd/sFvd/NiP+5gqR5DcH/cxNKxiqoNLHVGM
    mmeJq+xdnhVNh8V9h6pXCYrr9LLUgTFJ03lPXgCarqcEQqmZssUOS5B9LRinwE7O
    v+MbV8SaUZvYIUfYh5aXgjFAgE+Q5taBJwn5NQIDAQABAoIBAFurl5WlHX65A0HK
    s+vCYuWAhpXHoILtx7vECYLEdOVBeTeTSKuMWFExblZjw63r2LapDEx9/DDRDczn
    NZcKuBQksaoqp4iqsuRlnQEi5hRebTO8MyCLGMEuJrK42AtEIWxkvYFY+V7ezHI3
    40dftGNSDWbLcc0UBdoq/ScYAmKOEzlgDqcKvlCjUfcxZDQhIIJu+Jc9dHJSjAAF
    DgMbUzV+TPVnel7wL51A60zcmixoUWrkxb82wXh9sP9ed+rBCenR3vPPSX3PqmiK
    qxqcWkgZ2LD9dFYU2Ploy0jx+KnKpLLKTrs2CEloqS9CH/GkyneooKG7IDg4ljxm
    L4T5D0ECgYEA9Z5Uan5aOz7KTAZvAnDqg6+I8PxA497sIldH/S0E4BXfkLmuP/7N
    Tdv0qYJuiUwXjKu4KBENIn3BdIfJPyNTMKWAK9musIjr2Sd60v0/duj/a/zE9Q36
    vMfSGNL8rMkcDJnN66ldoJ4SoNtbwU8jYuuzfqAZYXF4Rkf+ipeyMskCgYEA6I2a
    3ExGYjrpm6Kuv8Iqyh9c3dPa9L5nkJDGhq0CFiOAlt4Ulk9H4Fvs/+5BDYSA3w/l
    3YK2S+HBBTgmJZ3+/I479Z/gNoEyPmomit3WT+fMJE3+1erzScbSlq7t9949xB1A
    qJ8F/PIpNl4z7VUJBQQxgzsphI1qrEqkDYAHvQ0CgYEAlmrTGbCtg5DNhMd/3kfW
    ZrTuMV7aQnK3u8Ql8xdJ4A2lL1V3L/vUMTVd3R1iojR2S5CyI99lYtUOz1WE2mTA
    wo7oMnKKN9RyUzeJUYMEBcdk/PX8jHJ2NnxM3yT+1rYGtnTOld7P1thXYilURMs5
    SZA9CXP0dydtV+UpLij+WXkCgYEAy3scBaa37zudLJEsVp2O00yd9XtqGrx/4f7L
    twuqx7RIz7mCSgMU4TuOJGJUiX9nQ8alWy0EVWEzg12eA0w70MCjtkgt54Mkc3hu
    QRPachBgj2Ovl339YpCVs0Nc9YWAhhkSeniqxKkfZnMG/KNrQPhqWmlp6pHSxO6K
    nUVpgAECgYEAnKWgIGlpX6BRAAvKfr1cNAAVY+qAYX1vbMgsTnya1k4Y7sqydEFS
    gMGipMv+BFw3oamkvB1v41oP4jPAym5u+XPvWhb6SUToldj1WUwRcLlzE710ogJy
    dWJC0Ieo7QZFJ9L/y8PFsKxCNRT7wRwLVCO+oEmxtIGLNM+Z53X+YMs=
    -----END RSA PRIVATE KEY-----
  KEY

  subject_types_supported [:public]

  resource_owner_from_access_token do |access_token|
    # Example implementation:
    # User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    # Example implementation:
    # resource_owner.current_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # sign_out resource_owner
    # redirect_to new_user_session_url
  end

  # Depending on your configuration, a DoubleRenderError could be raised
  # if render/redirect_to is called at some point before this callback is executed.
  # To avoid the DoubleRenderError, you could add these two lines at the beginning
  #  of this callback: (Reference: https://github.com/rails/rails/issues/25106)
  #   self.response_body = nil
  #   @_response_body = nil
  select_account_for_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # redirect_to account_select_url
  end

  subject do |resource_owner, application|
    # Example implementation:
    # resource_owner.id

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  # claims do
  #   normal_claim :_foo_ do |resource_owner|
  #     resource_owner.foo
  #   end

  #   normal_claim :_bar_ do |resource_owner|
  #     resource_owner.bar
  #   end
  # end
end
