class User < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :history
  has_secure_password
  acts_as_paranoid

  has_many :activities
  has_many :pricing_histories

  validates :email,
            uniqueness: true
  validates :email,
            email: true
  validates :password_confirmation,
            presence: true,
            if: :is_changing_password?
  validate :secure_password,
           if: :is_changing_password?

  def init
    self.auth_token ||= SecureRandom.hex(16)
  end

  def renew_auth_token!
    self.auth_token = SecureRandom.hex(16)
    self.save!
  end

  def is_changing_password=(value)
    @is_changing_password = value
  end

  def is_changing_password?
    @is_changing_password
  end

  def self.search(keywords)
    if keywords.present?
      condition = User.arel_table[:name].eq(keywords)
      keywords.split(' ').each do |keyword|
        condition = condition.or(User.arel_table[:name].        matches("%#{keyword}%"))
        condition = condition.or(User.arel_table[:email].       matches("%#{keyword}%"))
      end
      all.where(condition)
    else
      all
    end
  end

  def slug_candidates
    PinYin.permlink(self.name)
  end

  def async_send_reset_password_email
    self.delay.send_reset_password_email
  end

  def async_send_confirmation_email
    self.delay.send_confirmation_email
  end

  private

  def send_reset_password_email
    UserMailer.forgot_password_request(self).deliver_now
  end

  def send_confirmation_email
    UserMailer.confirmation(self).deliver_now
  end

  def secure_password
    result = true
    result = false if (password =~ /[a-z]/).blank? #lower letter test
    result = false if (password =~ /[A-Z]/).blank? #upper letter test
    result = false if (password =~ /[0-9]/).blank? #number test
    result = false if password.present? && password.size < 6
    if !result
      errors.add(:base, 'Password should be contains at least')
      errors.add(:base, '1 lower letter')
      errors.add(:base, '1 upper letter')
      errors.add(:base, '1 digit letter')
      errors.add(:base, 'the length greater than 5 letters')
    end
    return result
  end

end
