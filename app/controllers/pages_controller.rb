class PagesController < ApplicationController
  # GET /about
  def about
    @page = Page.find_by!(slug: 'about')
  end
  
  # GET /contacts
  def contacts
    @page = Page.find_by!(slug: 'contacts')
  end
  
  # GET /guides
  def guides
    @page = Page.find_by!(slug: 'guides')
  end
  
  # GET /
  def home
    @page = Page.find_by!(slug: 'home')
    @testimonials = Testimonial.where(published: true).order('position DESC').limit(100)
    @employees = Employee.where(published: true).order('position DESC').limit(100)
  end
  
  # GET /open_source
  def open_source
    @page = Page.find_by!(slug: 'open-source')
  end
end
