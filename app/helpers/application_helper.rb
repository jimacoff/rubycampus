#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Relationship and Fundraising Management for Higher Education          |
# +------------------------------------------------------------------------------------+
# | Copyright (C) 2008 Kevin Aleman, RubyCampus LLC Japan - https://rubycampus.org     |
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
# | You can contact RubyCampus, LLC. at email address info@rubycampus.org.             |
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

module ApplicationHelper                                    
    
  # Sets <body class=""> to controllers name for stylesheet hooks
  def body_tag_classes
    @body_tag_classes ||= [ RUBYCAMPUS, controller.controller_name ]
  end   
  
  # Sets title and optionally <body class=""> 
  def title(page_title,body_tag_klass=nil)
    if !body_tag_klass.nil?
      body_tag_classes << body_tag_klass
    end
    content_for(:title) { page_title }
  end
  
  # Renders link to official RubyCampus Wiki
  def link_to_help
    link_to _("Help"), RUBYCAMPUS_ORG_BASE_URL + "wiki/#{RUBYCAMPUS}/#{controller.controller_name.downcase}##{controller.action_name.downcase}", :popup => true
  end
  
  # Links to RubyCampus issue tracker and fill basic issue information
  def link_to_tracker_issues_new
    link_to _("New Issue"), RUBYCAMPUS_ORG_BASE_URL + "projects/#{RUBYCAMPUS}/issues/new", :popup => true
  end
  
  # Get current controllers name
  def current_controller_human_name
    controller.controller_name.singularize.titleize
  end 
  
  def current_controller_gettext_human_name
    _(current_controller_human_name)  
  end
   
  def current_controller_gettext_human_name_pluralized
    _(controller.controller_name.titleize)
  end
  
  # Renders links for views
  def link_to_extract
    link_to _("PDF"), { :action => :extract, :id => params[:id], :format => :pdf }, :class => "positive"
  end
  
  def link_to_edit
    link_to(_("Edit"), self.send(("edit_"+controller.controller_name.singularize+ "_path")), :class => "positive")
  end 
  
  def link_to_destroy
    link_to(_("Destroy"), self.send((controller.controller_name.singularize+ "_path")), :class => "negative", :confirm => (_("Really destroy %s?") % controller.controller_name.titleize), :method => :delete )
  end 
                
end
