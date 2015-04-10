require 'open-uri'

class SchemaSpy
  # Regexps use Java Regexp syntax for interpretation by SchemaSpy.jar
  # Matches require whole-string match `Matcher#matches()`
  TABLE_EXCLUDES = [
    'schema_migrations', # ActiveRecord migrations file
    '.*_\d{4,}$', # partitioned tables
    '^sym_.*' # symmetricDS
  ]
  TABLE_EXCLUDES_REGEXP = "(#{TABLE_EXCLUDES.join('|')})"

  def generate_docs(options = {})
    options = options.with_indifferent_access

    args = construct_args(options)
    arg_string = args.map { |option, value| "-#{option} '#{value}'" }.join(' ')

    puts 'SchemaSpy: Generating HTML documentation'
    system("java #{arg_string}")
  end

  # Uses OS-X-specific `open` command to open in default browser
  def open_docs(options = {})
    options = options.with_indifferent_access
    args = construct_args(options)

    system("open #{args[:o].join('index.html')}")
  end

  def download_missing_requirements
    download_schema_spy_jar unless find_schema_spy_jar
    download_jdbc_driver unless find_jdbc_driver
  end

  def download_schema_spy_jar
    source_url = 'http://downloads.sourceforge.net/project/schemaspy/schemaspy/SchemaSpy%205.0.0/schemaSpy_5.0.0.jar'
    dest_file = schema_spy_path.join('schemaSpy_5.0.0.jar')

    puts "Downloading #{source_url} to #{dest_file}"
    open(dest_file, 'wb') do |file|
      begin
        file << open(source_url).read
      rescue => e
        # cleanup unwritten file
        file.close
        File.delete(dest_file)
        raise e
      end
    end
  end

  def download_jdbc_driver
    source_url = 'https://github.com/garrettpatterson/pgjdbc/raw/master/postgresql.redshift.jar'
    dest_file = schema_spy_path.join('postgresql.redshift.jar')

    puts "Downloading #{source_url} to #{dest_file}"
    open(dest_file, 'wb') do |file|
      begin
        file << open(source_url).read
      rescue => e
        # cleanup unwritten file
        file.close
        File.delete(dest_file)
        raise e
      end
    end
  end

  private
  def schema_spy_path
    @schema_spy_path ||= Rails.root.join('script', 'schemaspy')
  end

  def default_output_path
    @default_output_path ||= Rails.root.join('doc', 'schema', 'html')
  end

  def find_schema_spy_jar
    Dir.glob(schema_spy_path.join('schemaSpy*\.jar')).first
  end

  def find_jdbc_driver
    Dir.glob(schema_spy_path.join('postgresql*\.jar')).first
  end

  def find_css_file
    schema_spy_path.join('schemaSpy.css').to_s
  end

  def find_meta_xml_file(cluster)
    if cluster.blank?
      raise ArgumentError.new("Unable to find meta.xml for unknown cluster. Specify :environment or :meta_file.")
    end

    schema_spy_path.join("#{cluster}.meta.xml").to_s
  end

  def construct_args(options)
    args = {}

    args[:jar] = options[:schema_spy_jar] || find_schema_spy_jar
    args[:dp] = options[:jdbc_driver] || find_jdbc_driver

    args[:loglevel] = options[:loglevel] if options.has_key?(:loglevel)

    environment = options[:environment] || Rails.env
    cluster = cluster_from_environment(environment)
    database_config = Rails.configuration.database_configuration[environment]
    args[:t] = 'pgsql'
    args[:s] = options[:schema] || 'public'
    args[:db] = options[:database] || database_config["database"]
    args[:u] = options[:username] || database_config["username"]
    args[:p] = options[:password] || database_config["password"]
    puts "Documenting cluster: #{environment}, database: #{args[:db]}"

    host = options[:host] || database_config["host"]
    port = options[:port] || database_config["port"]
    args[:host] = "#{host}:#{port}"

    args[:I] = options[:table_excludes_regexp] || TABLE_EXCLUDES_REGEXP

    unless options.has_key?(:meta_file) && options[:meta_file].blank?
      args[:meta] = options[:meta_file] || find_meta_xml_file(cluster)
    end

    base_output_path = Pathname.new(options[:base_output_path] || default_output_path)
    args[:o] = base_output_path.join(args[:db])

    unless options.has_key?(:css_file) && options[:css_file].blank?
      args[:css] = options[:css_file] || find_css_file
    end

    args
  end

  def cluster_from_environment(type)
    case type
    when /engineering$/i
      'engineering'
    when /ops$/i
      'ops'
    when /avails$/i
      'avails'
    end
  end
end
