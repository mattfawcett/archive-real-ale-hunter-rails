# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 0) do

  create_table "phpbb_acl_groups", :id => false, :force => true do |t|
    t.integer "group_id",       :limit => 3, :default => 0, :null => false
    t.integer "forum_id",       :limit => 3, :default => 0, :null => false
    t.integer "auth_option_id", :limit => 3, :default => 0, :null => false
    t.integer "auth_role_id",   :limit => 3, :default => 0, :null => false
    t.integer "auth_setting",   :limit => 1, :default => 0, :null => false
  end

  add_index "phpbb_acl_groups", ["auth_option_id"], :name => "auth_opt_id"
  add_index "phpbb_acl_groups", ["auth_role_id"], :name => "auth_role_id"
  add_index "phpbb_acl_groups", ["group_id"], :name => "group_id"

  create_table "phpbb_acl_options", :primary_key => "auth_option_id", :force => true do |t|
    t.string  "auth_option",  :limit => 50, :default => "",    :null => false
    t.boolean "is_global",                  :default => false, :null => false
    t.boolean "is_local",                   :default => false, :null => false
    t.boolean "founder_only",               :default => false, :null => false
  end

  add_index "phpbb_acl_options", ["auth_option"], :name => "auth_option"

  create_table "phpbb_acl_roles", :primary_key => "role_id", :force => true do |t|
    t.string  "role_name",                      :default => "", :null => false
    t.text    "role_description",                               :null => false
    t.string  "role_type",        :limit => 10, :default => "", :null => false
    t.integer "role_order",       :limit => 2,  :default => 0,  :null => false
  end

  add_index "phpbb_acl_roles", ["role_order"], :name => "role_order"
  add_index "phpbb_acl_roles", ["role_type"], :name => "role_type"

  create_table "phpbb_acl_roles_data", :id => false, :force => true do |t|
    t.integer "role_id",        :limit => 3, :default => 0, :null => false
    t.integer "auth_option_id", :limit => 3, :default => 0, :null => false
    t.integer "auth_setting",   :limit => 1, :default => 0, :null => false
  end

  add_index "phpbb_acl_roles_data", ["auth_option_id"], :name => "ath_op_id"

  create_table "phpbb_acl_users", :id => false, :force => true do |t|
    t.integer "user_id",        :limit => 3, :default => 0, :null => false
    t.integer "forum_id",       :limit => 3, :default => 0, :null => false
    t.integer "auth_option_id", :limit => 3, :default => 0, :null => false
    t.integer "auth_role_id",   :limit => 3, :default => 0, :null => false
    t.integer "auth_setting",   :limit => 1, :default => 0, :null => false
  end

  add_index "phpbb_acl_users", ["auth_option_id"], :name => "auth_option_id"
  add_index "phpbb_acl_users", ["auth_role_id"], :name => "auth_role_id"
  add_index "phpbb_acl_users", ["user_id"], :name => "user_id"

  create_table "phpbb_attachments", :primary_key => "attach_id", :force => true do |t|
    t.integer "post_msg_id",       :limit => 3,   :default => 0,     :null => false
    t.integer "topic_id",          :limit => 3,   :default => 0,     :null => false
    t.boolean "in_message",                       :default => false, :null => false
    t.integer "poster_id",         :limit => 3,   :default => 0,     :null => false
    t.boolean "is_orphan",                        :default => true,  :null => false
    t.string  "physical_filename",                :default => "",    :null => false
    t.string  "real_filename",                    :default => "",    :null => false
    t.integer "download_count",    :limit => 3,   :default => 0,     :null => false
    t.text    "attach_comment",                                      :null => false
    t.string  "extension",         :limit => 100, :default => "",    :null => false
    t.string  "mimetype",          :limit => 100, :default => "",    :null => false
    t.integer "filesize",                         :default => 0,     :null => false
    t.integer "filetime",                         :default => 0,     :null => false
    t.boolean "thumbnail",                        :default => false, :null => false
  end

  add_index "phpbb_attachments", ["filetime"], :name => "filetime"
  add_index "phpbb_attachments", ["is_orphan"], :name => "is_orphan"
  add_index "phpbb_attachments", ["post_msg_id"], :name => "post_msg_id"
  add_index "phpbb_attachments", ["poster_id"], :name => "poster_id"
  add_index "phpbb_attachments", ["topic_id"], :name => "topic_id"

  create_table "phpbb_banlist", :primary_key => "ban_id", :force => true do |t|
    t.integer "ban_userid",      :limit => 3,   :default => 0,     :null => false
    t.string  "ban_ip",          :limit => 40,  :default => "",    :null => false
    t.string  "ban_email",       :limit => 100, :default => "",    :null => false
    t.integer "ban_start",                      :default => 0,     :null => false
    t.integer "ban_end",                        :default => 0,     :null => false
    t.boolean "ban_exclude",                    :default => false, :null => false
    t.string  "ban_reason",                     :default => "",    :null => false
    t.string  "ban_give_reason",                :default => "",    :null => false
  end

  add_index "phpbb_banlist", ["ban_email", "ban_exclude"], :name => "ban_email"
  add_index "phpbb_banlist", ["ban_end"], :name => "ban_end"
  add_index "phpbb_banlist", ["ban_ip", "ban_exclude"], :name => "ban_ip"
  add_index "phpbb_banlist", ["ban_userid", "ban_exclude"], :name => "ban_user"

  create_table "phpbb_bbcodes", :primary_key => "bbcode_id", :force => true do |t|
    t.string  "bbcode_tag",          :limit => 16,       :default => "",    :null => false
    t.string  "bbcode_helpline",                         :default => "",    :null => false
    t.boolean "display_on_posting",                      :default => false, :null => false
    t.text    "bbcode_match",                                               :null => false
    t.text    "bbcode_tpl",          :limit => 16777215,                    :null => false
    t.text    "first_pass_match",    :limit => 16777215,                    :null => false
    t.text    "first_pass_replace",  :limit => 16777215,                    :null => false
    t.text    "second_pass_match",   :limit => 16777215,                    :null => false
    t.text    "second_pass_replace", :limit => 16777215,                    :null => false
  end

  add_index "phpbb_bbcodes", ["display_on_posting"], :name => "display_on_post"

  create_table "phpbb_bookmarks", :id => false, :force => true do |t|
    t.integer "topic_id", :limit => 3, :default => 0, :null => false
    t.integer "user_id",  :limit => 3, :default => 0, :null => false
  end

  create_table "phpbb_bots", :primary_key => "bot_id", :force => true do |t|
    t.boolean "bot_active",              :default => true, :null => false
    t.string  "bot_name",                :default => "",   :null => false
    t.integer "user_id",    :limit => 3, :default => 0,    :null => false
    t.string  "bot_agent",               :default => "",   :null => false
    t.string  "bot_ip",                  :default => "",   :null => false
  end

  add_index "phpbb_bots", ["bot_active"], :name => "bot_active"

  create_table "phpbb_config", :primary_key => "config_name", :force => true do |t|
    t.string  "config_value", :default => "",    :null => false
    t.boolean "is_dynamic",   :default => false, :null => false
  end

  add_index "phpbb_config", ["is_dynamic"], :name => "is_dynamic"

  create_table "phpbb_confirm", :id => false, :force => true do |t|
    t.string  "confirm_id",   :limit => 32, :default => "", :null => false
    t.string  "session_id",   :limit => 32, :default => "", :null => false
    t.integer "confirm_type", :limit => 1,  :default => 0,  :null => false
    t.string  "code",         :limit => 8,  :default => "", :null => false
    t.integer "seed",                       :default => 0,  :null => false
  end

  add_index "phpbb_confirm", ["confirm_type"], :name => "confirm_type"

  create_table "phpbb_disallow", :primary_key => "disallow_id", :force => true do |t|
    t.string "disallow_username", :default => "", :null => false
  end

  create_table "phpbb_drafts", :primary_key => "draft_id", :force => true do |t|
    t.integer "user_id",       :limit => 3,        :default => 0,  :null => false
    t.integer "topic_id",      :limit => 3,        :default => 0,  :null => false
    t.integer "forum_id",      :limit => 3,        :default => 0,  :null => false
    t.integer "save_time",                         :default => 0,  :null => false
    t.string  "draft_subject", :limit => 100,      :default => "", :null => false
    t.text    "draft_message", :limit => 16777215,                 :null => false
  end

  add_index "phpbb_drafts", ["save_time"], :name => "save_time"

  create_table "phpbb_extension_groups", :primary_key => "group_id", :force => true do |t|
    t.string  "group_name",                  :default => "",    :null => false
    t.integer "cat_id",         :limit => 1, :default => 0,     :null => false
    t.boolean "allow_group",                 :default => false, :null => false
    t.boolean "download_mode",               :default => true,  :null => false
    t.string  "upload_icon",                 :default => "",    :null => false
    t.integer "max_filesize",                :default => 0,     :null => false
    t.text    "allowed_forums",                                 :null => false
    t.boolean "allow_in_pm",                 :default => false, :null => false
  end

  create_table "phpbb_extensions", :primary_key => "extension_id", :force => true do |t|
    t.integer "group_id",  :limit => 3,   :default => 0,  :null => false
    t.string  "extension", :limit => 100, :default => "", :null => false
  end

  create_table "phpbb_forums", :primary_key => "forum_id", :force => true do |t|
    t.integer "parent_id",                :limit => 3,        :default => 0,     :null => false
    t.integer "left_id",                  :limit => 3,        :default => 0,     :null => false
    t.integer "right_id",                 :limit => 3,        :default => 0,     :null => false
    t.text    "forum_parents",            :limit => 16777215,                    :null => false
    t.string  "forum_name",                                   :default => "",    :null => false
    t.text    "forum_desc",                                                      :null => false
    t.string  "forum_desc_bitfield",                          :default => "",    :null => false
    t.integer "forum_desc_options",                           :default => 7,     :null => false
    t.string  "forum_desc_uid",           :limit => 8,        :default => "",    :null => false
    t.string  "forum_link",                                   :default => "",    :null => false
    t.string  "forum_password",           :limit => 40,       :default => "",    :null => false
    t.integer "forum_style",              :limit => 2,        :default => 0,     :null => false
    t.string  "forum_image",                                  :default => "",    :null => false
    t.text    "forum_rules",                                                     :null => false
    t.string  "forum_rules_link",                             :default => "",    :null => false
    t.string  "forum_rules_bitfield",                         :default => "",    :null => false
    t.integer "forum_rules_options",                          :default => 7,     :null => false
    t.string  "forum_rules_uid",          :limit => 8,        :default => "",    :null => false
    t.integer "forum_topics_per_page",    :limit => 1,        :default => 0,     :null => false
    t.integer "forum_type",               :limit => 1,        :default => 0,     :null => false
    t.integer "forum_status",             :limit => 1,        :default => 0,     :null => false
    t.integer "forum_posts",              :limit => 3,        :default => 0,     :null => false
    t.integer "forum_topics",             :limit => 3,        :default => 0,     :null => false
    t.integer "forum_topics_real",        :limit => 3,        :default => 0,     :null => false
    t.integer "forum_last_post_id",       :limit => 3,        :default => 0,     :null => false
    t.integer "forum_last_poster_id",     :limit => 3,        :default => 0,     :null => false
    t.string  "forum_last_post_subject",  :limit => 100,      :default => "",    :null => false
    t.integer "forum_last_post_time",                         :default => 0,     :null => false
    t.string  "forum_last_poster_name",                       :default => "",    :null => false
    t.string  "forum_last_poster_colour", :limit => 6,        :default => "",    :null => false
    t.integer "forum_flags",              :limit => 1,        :default => 32,    :null => false
    t.boolean "display_subforum_list",                        :default => true,  :null => false
    t.boolean "display_on_index",                             :default => true,  :null => false
    t.boolean "enable_indexing",                              :default => true,  :null => false
    t.boolean "enable_icons",                                 :default => true,  :null => false
    t.boolean "enable_prune",                                 :default => false, :null => false
    t.integer "prune_next",                                   :default => 0,     :null => false
    t.integer "prune_days",               :limit => 3,        :default => 0,     :null => false
    t.integer "prune_viewed",             :limit => 3,        :default => 0,     :null => false
    t.integer "prune_freq",               :limit => 3,        :default => 0,     :null => false
  end

  add_index "phpbb_forums", ["forum_last_post_id"], :name => "forum_lastpost_id"
  add_index "phpbb_forums", ["left_id", "right_id"], :name => "left_right_id"

  create_table "phpbb_forums_access", :id => false, :force => true do |t|
    t.integer "forum_id",   :limit => 3,  :default => 0,  :null => false
    t.integer "user_id",    :limit => 3,  :default => 0,  :null => false
    t.string  "session_id", :limit => 32, :default => "", :null => false
  end

  create_table "phpbb_forums_track", :id => false, :force => true do |t|
    t.integer "user_id",   :limit => 3, :default => 0, :null => false
    t.integer "forum_id",  :limit => 3, :default => 0, :null => false
    t.integer "mark_time",              :default => 0, :null => false
  end

  create_table "phpbb_forums_watch", :id => false, :force => true do |t|
    t.integer "forum_id",      :limit => 3, :default => 0,     :null => false
    t.integer "user_id",       :limit => 3, :default => 0,     :null => false
    t.boolean "notify_status",              :default => false, :null => false
  end

  add_index "phpbb_forums_watch", ["forum_id"], :name => "forum_id"
  add_index "phpbb_forums_watch", ["notify_status"], :name => "notify_stat"
  add_index "phpbb_forums_watch", ["user_id"], :name => "user_id"

  create_table "phpbb_groups", :primary_key => "group_id", :force => true do |t|
    t.integer "group_type",           :limit => 1, :default => 1,     :null => false
    t.boolean "group_founder_manage",              :default => false, :null => false
    t.string  "group_name",                        :default => "",    :null => false
    t.text    "group_desc",                                           :null => false
    t.string  "group_desc_bitfield",               :default => "",    :null => false
    t.integer "group_desc_options",                :default => 7,     :null => false
    t.string  "group_desc_uid",       :limit => 8, :default => "",    :null => false
    t.boolean "group_display",                     :default => false, :null => false
    t.string  "group_avatar",                      :default => "",    :null => false
    t.integer "group_avatar_type",    :limit => 1, :default => 0,     :null => false
    t.integer "group_avatar_width",   :limit => 2, :default => 0,     :null => false
    t.integer "group_avatar_height",  :limit => 2, :default => 0,     :null => false
    t.integer "group_rank",           :limit => 3, :default => 0,     :null => false
    t.string  "group_colour",         :limit => 6, :default => "",    :null => false
    t.integer "group_sig_chars",      :limit => 3, :default => 0,     :null => false
    t.boolean "group_receive_pm",                  :default => false, :null => false
    t.integer "group_message_limit",  :limit => 3, :default => 0,     :null => false
    t.boolean "group_legend",                      :default => true,  :null => false
  end

  add_index "phpbb_groups", ["group_legend", "group_name"], :name => "group_legend_name"

  create_table "phpbb_icons", :primary_key => "icons_id", :force => true do |t|
    t.string  "icons_url",                       :default => "",   :null => false
    t.integer "icons_width",        :limit => 1, :default => 0,    :null => false
    t.integer "icons_height",       :limit => 1, :default => 0,    :null => false
    t.integer "icons_order",        :limit => 3, :default => 0,    :null => false
    t.boolean "display_on_posting",              :default => true, :null => false
  end

  add_index "phpbb_icons", ["display_on_posting"], :name => "display_on_posting"

  create_table "phpbb_lang", :primary_key => "lang_id", :force => true do |t|
    t.string "lang_iso",          :limit => 30,  :default => "", :null => false
    t.string "lang_dir",          :limit => 30,  :default => "", :null => false
    t.string "lang_english_name", :limit => 100, :default => "", :null => false
    t.string "lang_local_name",                  :default => "", :null => false
    t.string "lang_author",                      :default => "", :null => false
  end

  add_index "phpbb_lang", ["lang_iso"], :name => "lang_iso"

  create_table "phpbb_log", :primary_key => "log_id", :force => true do |t|
    t.integer "log_type",      :limit => 1,        :default => 0,  :null => false
    t.integer "user_id",       :limit => 3,        :default => 0,  :null => false
    t.integer "forum_id",      :limit => 3,        :default => 0,  :null => false
    t.integer "topic_id",      :limit => 3,        :default => 0,  :null => false
    t.integer "reportee_id",   :limit => 3,        :default => 0,  :null => false
    t.string  "log_ip",        :limit => 40,       :default => "", :null => false
    t.integer "log_time",                          :default => 0,  :null => false
    t.text    "log_operation",                                     :null => false
    t.text    "log_data",      :limit => 16777215,                 :null => false
  end

  add_index "phpbb_log", ["forum_id"], :name => "forum_id"
  add_index "phpbb_log", ["log_type"], :name => "log_type"
  add_index "phpbb_log", ["reportee_id"], :name => "reportee_id"
  add_index "phpbb_log", ["topic_id"], :name => "topic_id"
  add_index "phpbb_log", ["user_id"], :name => "user_id"

  create_table "phpbb_moderator_cache", :id => false, :force => true do |t|
    t.integer "forum_id",         :limit => 3, :default => 0,    :null => false
    t.integer "user_id",          :limit => 3, :default => 0,    :null => false
    t.string  "username",                      :default => "",   :null => false
    t.integer "group_id",         :limit => 3, :default => 0,    :null => false
    t.string  "group_name",                    :default => "",   :null => false
    t.boolean "display_on_index",              :default => true, :null => false
  end

  add_index "phpbb_moderator_cache", ["display_on_index"], :name => "disp_idx"
  add_index "phpbb_moderator_cache", ["forum_id"], :name => "forum_id"

  create_table "phpbb_modules", :primary_key => "module_id", :force => true do |t|
    t.boolean "module_enabled",                :default => true, :null => false
    t.boolean "module_display",                :default => true, :null => false
    t.string  "module_basename",               :default => "",   :null => false
    t.string  "module_class",    :limit => 10, :default => "",   :null => false
    t.integer "parent_id",       :limit => 3,  :default => 0,    :null => false
    t.integer "left_id",         :limit => 3,  :default => 0,    :null => false
    t.integer "right_id",        :limit => 3,  :default => 0,    :null => false
    t.string  "module_langname",               :default => "",   :null => false
    t.string  "module_mode",                   :default => "",   :null => false
    t.string  "module_auth",                   :default => "",   :null => false
  end

  add_index "phpbb_modules", ["left_id", "right_id"], :name => "left_right_id"
  add_index "phpbb_modules", ["module_class", "left_id"], :name => "class_left_id"
  add_index "phpbb_modules", ["module_enabled"], :name => "module_enabled"

  create_table "phpbb_poll_options", :id => false, :force => true do |t|
    t.integer "poll_option_id",    :limit => 1, :default => 0, :null => false
    t.integer "topic_id",          :limit => 3, :default => 0, :null => false
    t.text    "poll_option_text",                              :null => false
    t.integer "poll_option_total", :limit => 3, :default => 0, :null => false
  end

  add_index "phpbb_poll_options", ["poll_option_id"], :name => "poll_opt_id"
  add_index "phpbb_poll_options", ["topic_id"], :name => "topic_id"

  create_table "phpbb_poll_votes", :id => false, :force => true do |t|
    t.integer "topic_id",       :limit => 3,  :default => 0,  :null => false
    t.integer "poll_option_id", :limit => 1,  :default => 0,  :null => false
    t.integer "vote_user_id",   :limit => 3,  :default => 0,  :null => false
    t.string  "vote_user_ip",   :limit => 40, :default => "", :null => false
  end

  add_index "phpbb_poll_votes", ["topic_id"], :name => "topic_id"
  add_index "phpbb_poll_votes", ["vote_user_id"], :name => "vote_user_id"
  add_index "phpbb_poll_votes", ["vote_user_ip"], :name => "vote_user_ip"

  create_table "phpbb_posts", :primary_key => "post_id", :force => true do |t|
    t.integer "topic_id",         :limit => 3,        :default => 0,     :null => false
    t.integer "forum_id",         :limit => 3,        :default => 0,     :null => false
    t.integer "poster_id",        :limit => 3,        :default => 0,     :null => false
    t.integer "icon_id",          :limit => 3,        :default => 0,     :null => false
    t.string  "poster_ip",        :limit => 40,       :default => "",    :null => false
    t.integer "post_time",                            :default => 0,     :null => false
    t.boolean "post_approved",                        :default => true,  :null => false
    t.boolean "post_reported",                        :default => false, :null => false
    t.boolean "enable_bbcode",                        :default => true,  :null => false
    t.boolean "enable_smilies",                       :default => true,  :null => false
    t.boolean "enable_magic_url",                     :default => true,  :null => false
    t.boolean "enable_sig",                           :default => true,  :null => false
    t.string  "post_username",                        :default => "",    :null => false
    t.string  "post_subject",     :limit => 100,      :default => "",    :null => false
    t.text    "post_text",        :limit => 16777215,                    :null => false
    t.string  "post_checksum",    :limit => 32,       :default => "",    :null => false
    t.boolean "post_attachment",                      :default => false, :null => false
    t.string  "bbcode_bitfield",                      :default => "",    :null => false
    t.string  "bbcode_uid",       :limit => 8,        :default => "",    :null => false
    t.boolean "post_postcount",                       :default => true,  :null => false
    t.integer "post_edit_time",                       :default => 0,     :null => false
    t.string  "post_edit_reason",                     :default => "",    :null => false
    t.integer "post_edit_user",   :limit => 3,        :default => 0,     :null => false
    t.integer "post_edit_count",  :limit => 2,        :default => 0,     :null => false
    t.boolean "post_edit_locked",                     :default => false, :null => false
  end

  add_index "phpbb_posts", ["forum_id"], :name => "forum_id"
  add_index "phpbb_posts", ["post_approved"], :name => "post_approved"
  add_index "phpbb_posts", ["post_subject", "post_text"], :name => "post_content"
  add_index "phpbb_posts", ["post_subject"], :name => "post_subject"
  add_index "phpbb_posts", ["post_text"], :name => "post_text"
  add_index "phpbb_posts", ["poster_id"], :name => "poster_id"
  add_index "phpbb_posts", ["poster_ip"], :name => "poster_ip"
  add_index "phpbb_posts", ["topic_id", "post_time"], :name => "tid_post_time"
  add_index "phpbb_posts", ["topic_id"], :name => "topic_id"

  create_table "phpbb_privmsgs", :primary_key => "msg_id", :force => true do |t|
    t.integer "root_level",          :limit => 3,        :default => 0,     :null => false
    t.integer "author_id",           :limit => 3,        :default => 0,     :null => false
    t.integer "icon_id",             :limit => 3,        :default => 0,     :null => false
    t.string  "author_ip",           :limit => 40,       :default => "",    :null => false
    t.integer "message_time",                            :default => 0,     :null => false
    t.boolean "enable_bbcode",                           :default => true,  :null => false
    t.boolean "enable_smilies",                          :default => true,  :null => false
    t.boolean "enable_magic_url",                        :default => true,  :null => false
    t.boolean "enable_sig",                              :default => true,  :null => false
    t.string  "message_subject",     :limit => 100,      :default => "",    :null => false
    t.text    "message_text",        :limit => 16777215,                    :null => false
    t.string  "message_edit_reason",                     :default => "",    :null => false
    t.integer "message_edit_user",   :limit => 3,        :default => 0,     :null => false
    t.boolean "message_attachment",                      :default => false, :null => false
    t.string  "bbcode_bitfield",                         :default => "",    :null => false
    t.string  "bbcode_uid",          :limit => 8,        :default => "",    :null => false
    t.integer "message_edit_time",                       :default => 0,     :null => false
    t.integer "message_edit_count",  :limit => 2,        :default => 0,     :null => false
    t.text    "to_address",                                                 :null => false
    t.text    "bcc_address",                                                :null => false
  end

  add_index "phpbb_privmsgs", ["author_id"], :name => "author_id"
  add_index "phpbb_privmsgs", ["author_ip"], :name => "author_ip"
  add_index "phpbb_privmsgs", ["message_time"], :name => "message_time"
  add_index "phpbb_privmsgs", ["root_level"], :name => "root_level"

  create_table "phpbb_privmsgs_folder", :primary_key => "folder_id", :force => true do |t|
    t.integer "user_id",     :limit => 3, :default => 0,  :null => false
    t.string  "folder_name",              :default => "", :null => false
    t.integer "pm_count",    :limit => 3, :default => 0,  :null => false
  end

  add_index "phpbb_privmsgs_folder", ["user_id"], :name => "user_id"

  create_table "phpbb_privmsgs_rules", :primary_key => "rule_id", :force => true do |t|
    t.integer "user_id",         :limit => 3, :default => 0,  :null => false
    t.integer "rule_check",      :limit => 3, :default => 0,  :null => false
    t.integer "rule_connection", :limit => 3, :default => 0,  :null => false
    t.string  "rule_string",                  :default => "", :null => false
    t.integer "rule_user_id",    :limit => 3, :default => 0,  :null => false
    t.integer "rule_group_id",   :limit => 3, :default => 0,  :null => false
    t.integer "rule_action",     :limit => 3, :default => 0,  :null => false
    t.integer "rule_folder_id",               :default => 0,  :null => false
  end

  add_index "phpbb_privmsgs_rules", ["user_id"], :name => "user_id"

  create_table "phpbb_privmsgs_to", :id => false, :force => true do |t|
    t.integer "msg_id",       :limit => 3, :default => 0,     :null => false
    t.integer "user_id",      :limit => 3, :default => 0,     :null => false
    t.integer "author_id",    :limit => 3, :default => 0,     :null => false
    t.boolean "pm_deleted",                :default => false, :null => false
    t.boolean "pm_new",                    :default => true,  :null => false
    t.boolean "pm_unread",                 :default => true,  :null => false
    t.boolean "pm_replied",                :default => false, :null => false
    t.boolean "pm_marked",                 :default => false, :null => false
    t.boolean "pm_forwarded",              :default => false, :null => false
    t.integer "folder_id",                 :default => 0,     :null => false
  end

  add_index "phpbb_privmsgs_to", ["author_id"], :name => "author_id"
  add_index "phpbb_privmsgs_to", ["msg_id"], :name => "msg_id"
  add_index "phpbb_privmsgs_to", ["user_id", "folder_id"], :name => "usr_flder_id"

  create_table "phpbb_profile_fields", :primary_key => "field_id", :force => true do |t|
    t.string  "field_name",                        :default => "",    :null => false
    t.integer "field_type",          :limit => 1,  :default => 0,     :null => false
    t.string  "field_ident",         :limit => 20, :default => "",    :null => false
    t.string  "field_length",        :limit => 20, :default => "",    :null => false
    t.string  "field_minlen",                      :default => "",    :null => false
    t.string  "field_maxlen",                      :default => "",    :null => false
    t.string  "field_novalue",                     :default => "",    :null => false
    t.string  "field_default_value",               :default => "",    :null => false
    t.string  "field_validation",    :limit => 20, :default => "",    :null => false
    t.boolean "field_required",                    :default => false, :null => false
    t.boolean "field_show_on_reg",                 :default => false, :null => false
    t.boolean "field_hide",                        :default => false, :null => false
    t.boolean "field_no_view",                     :default => false, :null => false
    t.boolean "field_active",                      :default => false, :null => false
    t.integer "field_order",         :limit => 3,  :default => 0,     :null => false
  end

  add_index "phpbb_profile_fields", ["field_order"], :name => "fld_ordr"
  add_index "phpbb_profile_fields", ["field_type"], :name => "fld_type"

  create_table "phpbb_profile_fields_data", :primary_key => "user_id", :force => true do |t|
  end

  create_table "phpbb_profile_fields_lang", :id => false, :force => true do |t|
    t.integer "field_id",   :limit => 3, :default => 0,  :null => false
    t.integer "lang_id",    :limit => 3, :default => 0,  :null => false
    t.integer "option_id",  :limit => 3, :default => 0,  :null => false
    t.integer "field_type", :limit => 1, :default => 0,  :null => false
    t.string  "lang_value",              :default => "", :null => false
  end

  create_table "phpbb_profile_lang", :id => false, :force => true do |t|
    t.integer "field_id",           :limit => 3, :default => 0,  :null => false
    t.integer "lang_id",            :limit => 3, :default => 0,  :null => false
    t.string  "lang_name",                       :default => "", :null => false
    t.text    "lang_explain",                                    :null => false
    t.string  "lang_default_value",              :default => "", :null => false
  end

  create_table "phpbb_ranks", :primary_key => "rank_id", :force => true do |t|
    t.string  "rank_title",                :default => "",    :null => false
    t.integer "rank_min",     :limit => 3, :default => 0,     :null => false
    t.boolean "rank_special",              :default => false, :null => false
    t.string  "rank_image",                :default => "",    :null => false
  end

  create_table "phpbb_reports", :primary_key => "report_id", :force => true do |t|
    t.integer "reason_id",     :limit => 2,        :default => 0,     :null => false
    t.integer "post_id",       :limit => 3,        :default => 0,     :null => false
    t.integer "user_id",       :limit => 3,        :default => 0,     :null => false
    t.boolean "user_notify",                       :default => false, :null => false
    t.boolean "report_closed",                     :default => false, :null => false
    t.integer "report_time",                       :default => 0,     :null => false
    t.text    "report_text",   :limit => 16777215,                    :null => false
  end

  create_table "phpbb_reports_reasons", :primary_key => "reason_id", :force => true do |t|
    t.string  "reason_title",                           :default => "", :null => false
    t.text    "reason_description", :limit => 16777215,                 :null => false
    t.integer "reason_order",       :limit => 2,        :default => 0,  :null => false
  end

  create_table "phpbb_search_results", :primary_key => "search_key", :force => true do |t|
    t.integer "search_time",                         :default => 0, :null => false
    t.text    "search_keywords", :limit => 16777215,                :null => false
    t.text    "search_authors",  :limit => 16777215,                :null => false
  end

  create_table "phpbb_search_wordlist", :primary_key => "word_id", :force => true do |t|
    t.string  "word_text",                :default => "",    :null => false
    t.boolean "word_common",              :default => false, :null => false
    t.integer "word_count",  :limit => 3, :default => 0,     :null => false
  end

  add_index "phpbb_search_wordlist", ["word_count"], :name => "wrd_cnt"
  add_index "phpbb_search_wordlist", ["word_text"], :name => "wrd_txt", :unique => true

  create_table "phpbb_search_wordmatch", :id => false, :force => true do |t|
    t.integer "post_id",     :limit => 3, :default => 0,     :null => false
    t.integer "word_id",     :limit => 3, :default => 0,     :null => false
    t.boolean "title_match",              :default => false, :null => false
  end

  add_index "phpbb_search_wordmatch", ["post_id"], :name => "post_id"
  add_index "phpbb_search_wordmatch", ["word_id", "post_id", "title_match"], :name => "unq_mtch", :unique => true
  add_index "phpbb_search_wordmatch", ["word_id"], :name => "word_id"

  create_table "phpbb_sessions", :primary_key => "session_id", :force => true do |t|
    t.integer "session_user_id",       :limit => 3,   :default => 0,     :null => false
    t.integer "session_forum_id",      :limit => 3,   :default => 0,     :null => false
    t.integer "session_last_visit",                   :default => 0,     :null => false
    t.integer "session_start",                        :default => 0,     :null => false
    t.integer "session_time",                         :default => 0,     :null => false
    t.string  "session_ip",            :limit => 40,  :default => "",    :null => false
    t.string  "session_browser",       :limit => 150, :default => "",    :null => false
    t.string  "session_forwarded_for",                :default => "",    :null => false
    t.string  "session_page",                         :default => "",    :null => false
    t.boolean "session_viewonline",                   :default => true,  :null => false
    t.boolean "session_autologin",                    :default => false, :null => false
    t.boolean "session_admin",                        :default => false, :null => false
  end

  add_index "phpbb_sessions", ["session_forum_id"], :name => "session_forum_id"
  add_index "phpbb_sessions", ["session_time"], :name => "session_time"
  add_index "phpbb_sessions", ["session_user_id"], :name => "session_user_id"

  create_table "phpbb_sessions_keys", :id => false, :force => true do |t|
    t.string  "key_id",     :limit => 32, :default => "", :null => false
    t.integer "user_id",    :limit => 3,  :default => 0,  :null => false
    t.string  "last_ip",    :limit => 40, :default => "", :null => false
    t.integer "last_login",               :default => 0,  :null => false
  end

  add_index "phpbb_sessions_keys", ["last_login"], :name => "last_login"

  create_table "phpbb_sitelist", :primary_key => "site_id", :force => true do |t|
    t.string  "site_ip",       :limit => 40, :default => "",    :null => false
    t.string  "site_hostname",               :default => "",    :null => false
    t.boolean "ip_exclude",                  :default => false, :null => false
  end

  create_table "phpbb_smilies", :primary_key => "smiley_id", :force => true do |t|
    t.string  "code",               :limit => 50, :default => "",   :null => false
    t.string  "emotion",            :limit => 50, :default => "",   :null => false
    t.string  "smiley_url",         :limit => 50, :default => "",   :null => false
    t.integer "smiley_width",       :limit => 2,  :default => 0,    :null => false
    t.integer "smiley_height",      :limit => 2,  :default => 0,    :null => false
    t.integer "smiley_order",       :limit => 3,  :default => 0,    :null => false
    t.boolean "display_on_posting",               :default => true, :null => false
  end

  add_index "phpbb_smilies", ["display_on_posting"], :name => "display_on_post"

  create_table "phpbb_styles", :primary_key => "style_id", :force => true do |t|
    t.string  "style_name",                   :default => "",   :null => false
    t.string  "style_copyright",              :default => "",   :null => false
    t.boolean "style_active",                 :default => true, :null => false
    t.integer "template_id",     :limit => 2, :default => 0,    :null => false
    t.integer "theme_id",        :limit => 2, :default => 0,    :null => false
    t.integer "imageset_id",     :limit => 2, :default => 0,    :null => false
  end

  add_index "phpbb_styles", ["imageset_id"], :name => "imageset_id"
  add_index "phpbb_styles", ["style_name"], :name => "style_name", :unique => true
  add_index "phpbb_styles", ["template_id"], :name => "template_id"
  add_index "phpbb_styles", ["theme_id"], :name => "theme_id"

  create_table "phpbb_styles_imageset", :primary_key => "imageset_id", :force => true do |t|
    t.string "imageset_name",                     :default => "", :null => false
    t.string "imageset_copyright",                :default => "", :null => false
    t.string "imageset_path",      :limit => 100, :default => "", :null => false
  end

  add_index "phpbb_styles_imageset", ["imageset_name"], :name => "imgset_nm", :unique => true

  create_table "phpbb_styles_imageset_data", :primary_key => "image_id", :force => true do |t|
    t.string  "image_name",     :limit => 200, :default => "", :null => false
    t.string  "image_filename", :limit => 200, :default => "", :null => false
    t.string  "image_lang",     :limit => 30,  :default => "", :null => false
    t.integer "image_height",   :limit => 2,   :default => 0,  :null => false
    t.integer "image_width",    :limit => 2,   :default => 0,  :null => false
    t.integer "imageset_id",    :limit => 2,   :default => 0,  :null => false
  end

  add_index "phpbb_styles_imageset_data", ["imageset_id"], :name => "i_d"

  create_table "phpbb_styles_template", :primary_key => "template_id", :force => true do |t|
    t.string  "template_name",                     :default => "",     :null => false
    t.string  "template_copyright",                :default => "",     :null => false
    t.string  "template_path",      :limit => 100, :default => "",     :null => false
    t.string  "bbcode_bitfield",                   :default => "kNg=", :null => false
    t.boolean "template_storedb",                  :default => false,  :null => false
  end

  add_index "phpbb_styles_template", ["template_name"], :name => "tmplte_nm", :unique => true

  create_table "phpbb_styles_template_data", :id => false, :force => true do |t|
    t.integer "template_id",       :limit => 2,        :default => 0,  :null => false
    t.string  "template_filename", :limit => 100,      :default => "", :null => false
    t.text    "template_included",                                     :null => false
    t.integer "template_mtime",                        :default => 0,  :null => false
    t.text    "template_data",     :limit => 16777215,                 :null => false
  end

  add_index "phpbb_styles_template_data", ["template_filename"], :name => "tfn"
  add_index "phpbb_styles_template_data", ["template_id"], :name => "tid"

  create_table "phpbb_styles_theme", :primary_key => "theme_id", :force => true do |t|
    t.string  "theme_name",                          :default => "",    :null => false
    t.string  "theme_copyright",                     :default => "",    :null => false
    t.string  "theme_path",      :limit => 100,      :default => "",    :null => false
    t.boolean "theme_storedb",                       :default => false, :null => false
    t.integer "theme_mtime",                         :default => 0,     :null => false
    t.text    "theme_data",      :limit => 16777215,                    :null => false
  end

  add_index "phpbb_styles_theme", ["theme_name"], :name => "theme_name", :unique => true

  create_table "phpbb_topics", :primary_key => "topic_id", :force => true do |t|
    t.integer "forum_id",                  :limit => 3,   :default => 0,     :null => false
    t.integer "icon_id",                   :limit => 3,   :default => 0,     :null => false
    t.boolean "topic_attachment",                         :default => false, :null => false
    t.boolean "topic_approved",                           :default => true,  :null => false
    t.boolean "topic_reported",                           :default => false, :null => false
    t.string  "topic_title",               :limit => 100, :default => "",    :null => false
    t.integer "topic_poster",              :limit => 3,   :default => 0,     :null => false
    t.integer "topic_time",                               :default => 0,     :null => false
    t.integer "topic_time_limit",                         :default => 0,     :null => false
    t.integer "topic_views",               :limit => 3,   :default => 0,     :null => false
    t.integer "topic_replies",             :limit => 3,   :default => 0,     :null => false
    t.integer "topic_replies_real",        :limit => 3,   :default => 0,     :null => false
    t.integer "topic_status",              :limit => 1,   :default => 0,     :null => false
    t.integer "topic_type",                :limit => 1,   :default => 0,     :null => false
    t.integer "topic_first_post_id",       :limit => 3,   :default => 0,     :null => false
    t.string  "topic_first_poster_name",                  :default => "",    :null => false
    t.string  "topic_first_poster_colour", :limit => 6,   :default => "",    :null => false
    t.integer "topic_last_post_id",        :limit => 3,   :default => 0,     :null => false
    t.integer "topic_last_poster_id",      :limit => 3,   :default => 0,     :null => false
    t.string  "topic_last_poster_name",                   :default => "",    :null => false
    t.string  "topic_last_poster_colour",  :limit => 6,   :default => "",    :null => false
    t.string  "topic_last_post_subject",   :limit => 100, :default => "",    :null => false
    t.integer "topic_last_post_time",                     :default => 0,     :null => false
    t.integer "topic_last_view_time",                     :default => 0,     :null => false
    t.integer "topic_moved_id",            :limit => 3,   :default => 0,     :null => false
    t.boolean "topic_bumped",                             :default => false, :null => false
    t.integer "topic_bumper",              :limit => 3,   :default => 0,     :null => false
    t.string  "poll_title",                               :default => "",    :null => false
    t.integer "poll_start",                               :default => 0,     :null => false
    t.integer "poll_length",                              :default => 0,     :null => false
    t.integer "poll_max_options",          :limit => 1,   :default => 1,     :null => false
    t.integer "poll_last_vote",                           :default => 0,     :null => false
    t.boolean "poll_vote_change",                         :default => false, :null => false
  end

  add_index "phpbb_topics", ["forum_id", "topic_approved", "topic_last_post_id"], :name => "forum_appr_last"
  add_index "phpbb_topics", ["forum_id", "topic_last_post_time", "topic_moved_id"], :name => "fid_time_moved"
  add_index "phpbb_topics", ["forum_id", "topic_type"], :name => "forum_id_type"
  add_index "phpbb_topics", ["forum_id"], :name => "forum_id"
  add_index "phpbb_topics", ["topic_approved"], :name => "topic_approved"
  add_index "phpbb_topics", ["topic_last_post_time"], :name => "last_post_time"

  create_table "phpbb_topics_posted", :id => false, :force => true do |t|
    t.integer "user_id",      :limit => 3, :default => 0,     :null => false
    t.integer "topic_id",     :limit => 3, :default => 0,     :null => false
    t.boolean "topic_posted",              :default => false, :null => false
  end

  create_table "phpbb_topics_track", :id => false, :force => true do |t|
    t.integer "user_id",   :limit => 3, :default => 0, :null => false
    t.integer "topic_id",  :limit => 3, :default => 0, :null => false
    t.integer "forum_id",  :limit => 3, :default => 0, :null => false
    t.integer "mark_time",              :default => 0, :null => false
  end

  add_index "phpbb_topics_track", ["forum_id"], :name => "forum_id"

  create_table "phpbb_topics_watch", :id => false, :force => true do |t|
    t.integer "topic_id",      :limit => 3, :default => 0,     :null => false
    t.integer "user_id",       :limit => 3, :default => 0,     :null => false
    t.boolean "notify_status",              :default => false, :null => false
  end

  add_index "phpbb_topics_watch", ["notify_status"], :name => "notify_stat"
  add_index "phpbb_topics_watch", ["topic_id"], :name => "topic_id"
  add_index "phpbb_topics_watch", ["user_id"], :name => "user_id"

  create_table "phpbb_user_group", :id => false, :force => true do |t|
    t.integer "group_id",     :limit => 3, :default => 0,     :null => false
    t.integer "user_id",      :limit => 3, :default => 0,     :null => false
    t.boolean "group_leader",              :default => false, :null => false
    t.boolean "user_pending",              :default => true,  :null => false
  end

  add_index "phpbb_user_group", ["group_id"], :name => "group_id"
  add_index "phpbb_user_group", ["group_leader"], :name => "group_leader"
  add_index "phpbb_user_group", ["user_id"], :name => "user_id"

  create_table "phpbb_users", :primary_key => "user_id", :force => true do |t|
    t.integer "user_type",                :limit => 1,                                      :default => 0,           :null => false
    t.integer "group_id",                 :limit => 3,                                      :default => 3,           :null => false
    t.text    "user_permissions",         :limit => 16777215,                                                        :null => false
    t.integer "user_perm_from",           :limit => 3,                                      :default => 0,           :null => false
    t.string  "user_ip",                  :limit => 40,                                     :default => "",          :null => false
    t.integer "user_regdate",                                                               :default => 0,           :null => false
    t.string  "username",                                                                   :default => "",          :null => false
    t.string  "username_clean",                                                             :default => "",          :null => false
    t.string  "user_password",            :limit => 40,                                     :default => "",          :null => false
    t.integer "user_passchg",                                                               :default => 0,           :null => false
    t.boolean "user_pass_convert",                                                          :default => false,       :null => false
    t.string  "user_email",               :limit => 100,                                    :default => "",          :null => false
    t.integer "user_email_hash",          :limit => 8,                                      :default => 0,           :null => false
    t.string  "user_birthday",            :limit => 10,                                     :default => "",          :null => false
    t.integer "user_lastvisit",                                                             :default => 0,           :null => false
    t.integer "user_lastmark",                                                              :default => 0,           :null => false
    t.integer "user_lastpost_time",                                                         :default => 0,           :null => false
    t.string  "user_lastpage",            :limit => 200,                                    :default => "",          :null => false
    t.string  "user_last_confirm_key",    :limit => 10,                                     :default => "",          :null => false
    t.integer "user_last_search",                                                           :default => 0,           :null => false
    t.integer "user_warnings",            :limit => 1,                                      :default => 0,           :null => false
    t.integer "user_last_warning",                                                          :default => 0,           :null => false
    t.integer "user_login_attempts",      :limit => 1,                                      :default => 0,           :null => false
    t.integer "user_inactive_reason",     :limit => 1,                                      :default => 0,           :null => false
    t.integer "user_inactive_time",                                                         :default => 0,           :null => false
    t.integer "user_posts",               :limit => 3,                                      :default => 0,           :null => false
    t.string  "user_lang",                :limit => 30,                                     :default => "",          :null => false
    t.decimal "user_timezone",                                :precision => 5, :scale => 2, :default => 0.0,         :null => false
    t.boolean "user_dst",                                                                   :default => false,       :null => false
    t.string  "user_dateformat",          :limit => 30,                                     :default => "d M Y H:i", :null => false
    t.integer "user_style",               :limit => 2,                                      :default => 0,           :null => false
    t.integer "user_rank",                :limit => 3,                                      :default => 0,           :null => false
    t.string  "user_colour",              :limit => 6,                                      :default => "",          :null => false
    t.integer "user_new_privmsg",                                                           :default => 0,           :null => false
    t.integer "user_unread_privmsg",                                                        :default => 0,           :null => false
    t.integer "user_last_privmsg",                                                          :default => 0,           :null => false
    t.boolean "user_message_rules",                                                         :default => false,       :null => false
    t.integer "user_full_folder",                                                           :default => -3,          :null => false
    t.integer "user_emailtime",                                                             :default => 0,           :null => false
    t.integer "user_topic_show_days",     :limit => 2,                                      :default => 0,           :null => false
    t.string  "user_topic_sortby_type",   :limit => 1,                                      :default => "t",         :null => false
    t.string  "user_topic_sortby_dir",    :limit => 1,                                      :default => "d",         :null => false
    t.integer "user_post_show_days",      :limit => 2,                                      :default => 0,           :null => false
    t.string  "user_post_sortby_type",    :limit => 1,                                      :default => "t",         :null => false
    t.string  "user_post_sortby_dir",     :limit => 1,                                      :default => "a",         :null => false
    t.boolean "user_notify",                                                                :default => false,       :null => false
    t.boolean "user_notify_pm",                                                             :default => true,        :null => false
    t.integer "user_notify_type",         :limit => 1,                                      :default => 0,           :null => false
    t.boolean "user_allow_pm",                                                              :default => true,        :null => false
    t.boolean "user_allow_viewonline",                                                      :default => true,        :null => false
    t.boolean "user_allow_viewemail",                                                       :default => true,        :null => false
    t.boolean "user_allow_massemail",                                                       :default => true,        :null => false
    t.integer "user_options",                                                               :default => 895,         :null => false
    t.string  "user_avatar",                                                                :default => "",          :null => false
    t.integer "user_avatar_type",         :limit => 1,                                      :default => 0,           :null => false
    t.integer "user_avatar_width",        :limit => 2,                                      :default => 0,           :null => false
    t.integer "user_avatar_height",       :limit => 2,                                      :default => 0,           :null => false
    t.text    "user_sig",                 :limit => 16777215,                                                        :null => false
    t.string  "user_sig_bbcode_uid",      :limit => 8,                                      :default => "",          :null => false
    t.string  "user_sig_bbcode_bitfield",                                                   :default => "",          :null => false
    t.string  "user_from",                :limit => 100,                                    :default => "",          :null => false
    t.string  "user_icq",                 :limit => 15,                                     :default => "",          :null => false
    t.string  "user_aim",                                                                   :default => "",          :null => false
    t.string  "user_yim",                                                                   :default => "",          :null => false
    t.string  "user_msnm",                                                                  :default => "",          :null => false
    t.string  "user_jabber",                                                                :default => "",          :null => false
    t.string  "user_website",             :limit => 200,                                    :default => "",          :null => false
    t.text    "user_occ",                                                                                            :null => false
    t.text    "user_interests",                                                                                      :null => false
    t.string  "user_actkey",              :limit => 32,                                     :default => "",          :null => false
    t.string  "user_newpasswd",           :limit => 40,                                     :default => "",          :null => false
    t.string  "user_form_salt",           :limit => 32,                                     :default => "",          :null => false
    t.string  "user_openid",                                                                :default => "",          :null => false
  end

  add_index "phpbb_users", ["user_birthday"], :name => "user_birthday"
  add_index "phpbb_users", ["user_email_hash"], :name => "user_email_hash"
  add_index "phpbb_users", ["user_type"], :name => "user_type"
  add_index "phpbb_users", ["username_clean"], :name => "username_clean", :unique => true

  create_table "phpbb_warnings", :primary_key => "warning_id", :force => true do |t|
    t.integer "user_id",      :limit => 3, :default => 0, :null => false
    t.integer "post_id",      :limit => 3, :default => 0, :null => false
    t.integer "log_id",       :limit => 3, :default => 0, :null => false
    t.integer "warning_time",              :default => 0, :null => false
  end

  create_table "phpbb_words", :primary_key => "word_id", :force => true do |t|
    t.string "word",        :default => "", :null => false
    t.string "replacement", :default => "", :null => false
  end

  create_table "phpbb_zebra", :id => false, :force => true do |t|
    t.integer "user_id",  :limit => 3, :default => 0,     :null => false
    t.integer "zebra_id", :limit => 3, :default => 0,     :null => false
    t.boolean "friend",                :default => false, :null => false
    t.boolean "foe",                   :default => false, :null => false
  end

end
