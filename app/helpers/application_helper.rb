module ApplicationHelper

  def env_with_emoji
    env = Rails.env
    case env
    when "development"
      "🟡 dev 🛠️"
    when "test"
      "🔴 Test 🧪"
    when "production"
      "🟢 prod 🚀"
    else
      "#{env.capitalize} 🌍"
    end
  end
end
