#--                                                  /THIS FILE IS A PART OF RUBYCAMPUS/
# +------------------------------------------------------------------------------------+
# | RubyCampus - Student & Alumni Relationship Management Software                     |
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

class DashboardController < ApplicationController
  before_filter :login_required

  WIDGETS = { 'my_contacts' => _("My Contacts"), 'activity' => _("Activity"), 'document' => _("Document") }.freeze
  DEFAULT_LAYOUT = { 'top' => ['my_contacts'], 'left' => ['activity'], 'right' => ['document'] }.freeze
  verify :xhr => true, :session => :page_layout, :only => [:add_widget, :remove_widget, :order_widgets]

  def index
    page
    render :action => 'page'
  end

  def page
    @user = current_user
    @widgets = @user.preference[:my_page_layout] || DEFAULT_LAYOUT
  end

  def page_layout
    @user = current_user
    @widgets = @user.preference[:my_page_layout] || DEFAULT_LAYOUT.dup
    session[:page_layout] = @widgets
    %w(top left right).each {|f| session[:page_layout][f] ||= [] }
    @widget_options = []
    WIDGETS.each {|k, v| @widget_options << [_(v), k]}
  end

  def add_widget
    widget = params[:widget]
    render(:nothing => true) and return unless widget && (WIDGETS.keys.include? widget)
    @user = current_user
    %w(top left right).each {|f| (session[:page_layout][f] ||= []).delete widget }
    session[:page_layout]['top'].unshift widget
    render :partial => "widget", :locals => {:user => @user, :widget_name => widget}
  end

  def remove_widget
    widget = params[:widget]
    %w(top left right).each {|f| (session[:page_layout][f] ||= []).delete widget }
    render :nothing => true
  end

  def order_widgets
    group = params[:group]
    group_items = params["list-#{group}"]
    if group_items and group_items.is_a? Array
      %w(top left right).each {|f|
        session[:page_layout][f] = (session[:page_layout][f] || []) - group_items
      }
      session[:page_layout][group] = group_items
    end
    render :nothing => true
  end

  def page_layout_save
    @user = current_user
    @user.preference[:my_page_layout] = session[:page_layout] if session[:page_layout]
    @user.preference.save
    session[:page_layout] = nil
    redirect_to :action => 'page'
  end
end