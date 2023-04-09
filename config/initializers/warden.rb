Warden::Strategies.add(:api_token) do
    def valid?
      api_token.present?
    end

    def authenticate!
      user = User.find_by(private_api_key: api_token)

      if user
        success!(user)
      else
        fail!('Invalid email or password')
      end
    end


    def api_token
      env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
    end
end
