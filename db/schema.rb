# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_07_125549) do

  create_table "classifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "code"
    t.string "class_name"
    t.json "sub_classes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diseases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "disease_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drug_imprints", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "drug_id"
    t.string "item_name"
    t.text "description"
    t.string "dosage_form"
    t.string "drug_image"
    t.string "print_front"
    t.string "print_back"
    t.string "drug_shape"
    t.string "color_front"
    t.string "color_back"
    t.string "line_front"
    t.string "line_back"
    t.decimal "length_long", precision: 10, scale: 3
    t.decimal "length_short", precision: 10, scale: 3
    t.decimal "thickness", precision: 10, scale: 3
    t.string "mark_content_front"
    t.string "mark_content_back"
    t.string "mark_img_front"
    t.string "mark_img_back"
    t.string "mark_code_front"
    t.string "mark_code_back"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drug_id"], name: "index_drug_imprints_on_drug_id"
  end

  create_table "drugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "item_seq"
    t.string "item_name"
    t.json "ingr_kor_name"
    t.json "package_insert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "ingr_eng_name"
    t.string "atc_code"
    t.index ["item_name"], name: "index_drugs_on_item_name"
  end

  create_table "drugs_dur_ingrs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "drug_id", null: false
    t.bigint "dur_ingr_id", null: false
  end

  create_table "dur_ingrs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "dur_code"
    t.string "ingr_eng_name"
    t.string "ingr_kor_name"
    t.string "related_ingr_code"
    t.string "related_ingr_kor_name"
    t.string "related_ingr_eng_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingr_eng_name"], name: "index_dur_ingrs_on_ingr_eng_name"
    t.index ["ingr_kor_name"], name: "index_dur_ingrs_on_ingr_kor_name"
    t.index ["related_ingr_kor_name"], name: "index_dur_ingrs_on_related_ingr_kor_name"
  end

  create_table "interactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "interaction_type"
    t.json "first_ingr"
    t.json "second_ingr"
    t.string "review"
    t.string "note"
    t.text "more_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_terms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.json "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplement_ingrs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "approval_no"
    t.string "ingr_name"
    t.string "enterprise_name"
    t.json "benefits"
    t.json "warnings"
    t.string "daily_intake"
    t.string "daily_intake_max"
    t.string "daily_intake_min"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "active_ingr"
    t.index ["ingr_name"], name: "index_supplement_ingrs_on_ingr_name"
  end

  create_table "supplement_ingrs_supplements", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "supplement_id", null: false
    t.bigint "supplement_ingr_id", null: false
  end

  create_table "supplements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "production_code"
    t.string "product_name"
    t.string "enterprise_name"
    t.json "benefits"
    t.text "suggested_use"
    t.text "ingredients"
    t.json "storage"
    t.string "shelf_life"
    t.string "description"
    t.json "warnings"
    t.json "standard"
    t.date "approval_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_name"], name: "index_supplements_on_product_name"
  end

end
