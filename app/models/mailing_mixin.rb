#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Relationship Management & Alumni Development Software                 |
# +------------------------------------------------------------------------------------+
# | Copyright (C) 2008 Kevin Aleman, RubyCampus LLC - https://rubycampus.org           |
# +------------------------------------------------------------------------------------+
# |                                                                                    |
# | This program is free software; you can redistribute it and/or modify it under the  |
# | terms of the GNU Affero General Public License version 3 as published by the Free  |
# | Software Foundation with the addition of the following permission added to Section |
# | 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK IN WHICH THE     |
# | COPYRIGHT IS OWNED BY RUBYCAMPUS LLC, RUBYCAMPUS LLC DISCLAIMS THE WARRANTY OF NON |
# | INFRINGEMENT OF THIRD PARTY RIGHTS.                                                |
# |                                                                                    |
# | This program is distributed in the hope that it will be useful, but WITHOUT ANY    |
# | WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A    |
# | PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.   |
# |                                                                                    |
# | You should have received a copy of the GNU Affero General Public License along     |
# | with this program; if not, see http://www.gnu.org/licenses or write to the Free    |
# | Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  |
# | USA.                                                                               |
# |                                                                                    |
# | You can contact RubyCampus, LLC. at email address project@rubycampus.org.          |
# |                                                                                    |
# | The interactive user interfaces in modified source and object code versions of     |
# | this program must display Appropriate Legal Notices, as required under Section 5   |
# | of the GNU Affero General Public License version 3.                                |
# |                                                                                    |
# | In accordance with Section 7(b) of the GNU Affero General Public License version   |
# | 3, these Appropriate Legal Notices must retain the display of the "Powered by      |
# | RubyCampus" logo. If the display of the logo is not reasonably feasible for        |
# | technical reasons, the Appropriate Legal Notices must display the words "Powered   |
# | by RubyCampus".                                                                    |
# +------------------------------------------------------------------------------------+
#++

class MailingMixin < ActiveRecord::Base 
  # Excludes model from being included in PO template
  require 'gettext/rails'
  untranslate_all
   
  # begin Associations
    belongs_to :mailing_mixin_type
  # end Associations
  
  # begin Validations
    validates_presence_of :name
    validates_presence_of :mailing_mixin_type_name
    validates_presence_of :subject
    validates_presence_of :html
    validates_presence_of :text
  # ends Validations
  
  # Searchable attributes
  searchable_by :name
          
  # Lists qualifying model attributes for use by auto completion in forms
  def self.find_for_auto_complete_lookup(search)
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])  
  end
  
  #:stopdoc:
    # Virtual Attributes for auto complete
      # begin mailing_mixin_type
        def mailing_mixin_type_name
          mailing_mixin_type.name if mailing_mixin_type
        end

        def mailing_mixin_type_name=(name)
          self.mailing_mixin_type = MailingMixinType.find_by_name(name) unless name.blank?
        end
      # end mailing_mixin_type
    # Virtual Attributes for auto complete
  #:startdoc:

end