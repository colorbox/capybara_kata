require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  Capybara.add_selector(:row) do
    xpath { |num| ".//tbody/tr[#{num}]" }
  end

  setup do
    @user = users(:one)
  end

  test 'add_selector' do
    visit users_url

    row = find(:row, 3)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "visiting the index2" do
    visit users_url
    click_on "New User"

    field = find('input#user_name').ancestor('.field')
  end

  test "sibiling" do
    visit users_url
    sib2 = find('.sib1').sibling('.sib2')
    sib3 = find('.sib1').sibling('.sib3')
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    input = find('input#user_name')
    input.set(@user.name)

    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "creating a User 2" do
    visit users_url
    click_on "New User"

    input = find('input#user_name')
    input.set(@user.name)

    submit_button = find('input[value="Create User"]')
    submit_button.click

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "find_button find_link" do
    visit users_url

    new_user_link = find_link(text: 'New User')
    new_user_link.click

    input = find('input#user_name')
    input.set(@user.name)

    button = find_button(value:'Create User')
    button.click

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "find_by_id" do
    visit users_url

    find_by_id('id_ans')
  end

  test "find_field" do
    visit users_url
    click_on "New User"

    find('.field')
    find_field()
    find_field(name: 'user[name]')
    find_field('Name')
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end

  test "checked? check" do
    visit users_url

    assert_equal(false, find('input#page_freezeflag').checked?)

    cb =  find('input#page_freezeflag')
    cb.check

    assert_equal(true, find('input#page_freezeflag').checked?)

    cb.uncheck

    assert_equal(false, find('input#page_freezeflag').checked?)
  end

  test "choose" do
    visit users_url

    rb = find('#radio_category_socrates')
    assert_equal(false, rb.checked?)
    rb.choose
    assert_equal(true, rb.checked?)
  end

  test 'select unselect' do
    visit users_url

    assert_equal('', find('#single_select').value)
    find('#single_select').select('select1')
    assert_equal('select1', find('#single_select').value)
    find('#single_select').select('select2')
    assert_equal('select2', find('#single_select').value)

    find('#multiple_select').select('select1')
    assert_equal(['select1'], find('#multiple_select').value)
    find('#multiple_select').select('select2')
    assert_equal(['select1','select2'], find('#multiple_select').value)

    find('#multiple_select').unselect('select1')
    assert_equal(['select2'], find('#multiple_select').value)
    find('#multiple_select').unselect('select2')
    assert_equal([], find('#multiple_select').value)
  end

  test 'attach_file' do
    visit users_url

    assert_equal('', find('#attachment').value)
    attach_file(:attachment, "#{Rails.root}/test/fixtures/files/attach.png")
    assert_equal(true, find('#attachment').value.include?('attach.png'))
  end
end
