#!/bin/bash
# Build a table documentation template suitable for inserting into a migration
# Creates change_comment lines for all columns in the specified table.
#
# Usage: generate_doc_template tablename
# Optionally: PSQL='psql -h $HOST -U $USER ...' generate_doc_template tablename
#
# Output: the name of the template file in the local path

TABLENAME=$1
[ $# -ne 1 ] && { echo "Usage: $0 tablename" >&2 ; exit 1; }

# Use psql unless PSQL is already defined to some other command/alias
PSQL=${PSQL-psql}

PSQL_DESCRIBE_OUTPUT=${TABLENAME}_describe.tmp
DOCUMENTATION_TEMPLATE_OUTPUT=${TABLENAME}_doc_template.rb

$PSQL -o $PSQL_DESCRIBE_OUTPUT -c "\\d $TABLENAME"

ruby -n -e '
  BEGIN {
    tablename = ARGV.shift;
    puts "    change_table :#{tablename} do |t|";
    puts "      t.change_table_comment nil"
  }
  next if $. <= 3 # skip 3-line header;
  next unless $_[/\|/]
  colname = $_.split(/\|/)[0].strip;
  puts "      t.change_comment :#{colname}, nil";
  END { puts "    end" }' \
  $TABLENAME $PSQL_DESCRIBE_OUTPUT >$DOCUMENTATION_TEMPLATE_OUTPUT

rm $PSQL_DESCRIBE_OUTPUT

echo $DOCUMENTATION_TEMPLATE_OUTPUT
