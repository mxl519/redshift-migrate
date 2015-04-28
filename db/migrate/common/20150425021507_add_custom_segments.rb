class AddCustomSegments < ActiveRecord::Migration
  def change
    create_table "custom_segments", comment: TABLE_COMMENT do |t|
      t.integer "id", null: false, encode: :delta
      t.string "name", encode: :lzo
      t.string "source_paths", limit: 4095, encode: :lzo, comment: SOURCE_PATHS_COMMENT
      t.string "segment_path", encode: :lzo, comment: SEGMENT_PATH_COMMENT
      t.string "segment_id", encode: :lzo, comment: SEGMENT_ID_COMMENT
      t.datetime "created_at", null: false, encode: :lzo
      t.datetime "updated_at", null: false, encode: :lzo
    end
  end

  TABLE_COMMENT = %Q[
    Ventura user-created segments.
  ]

  SOURCE_PATHS_COMMENT = %Q[
    Source file S3 paths.

    Full s3 paths starting with s3:// .
    Formatted as YAML or CSV depending on whether uploaded by Symmetric or the daily uploader.
  ]
  SEGMENT_PATH_COMMENT = %Q[
    Final combined S3 path for use in user profile generation.

    Path is relative to the VENICE_EVENTS_TSV bucket.
    Source files are copied and concatenated into this location after validation.
    Path may contain multiple files if the total would have exceeded Ventura's file size limit (100,000 lines).
  ]
  SEGMENT_ID_COMMENT = %Q[
    Segment ID.

    Allocated in a specific range to avoid conflicts with Geocookie and third-party segment IDs.
  ]
end
