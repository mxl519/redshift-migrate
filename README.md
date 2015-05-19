PROJECT FOR RUNNING REDSHIFT MIGRATIONS

USER SPECIFIC SANDBOXES
=======================
Users can create isolated databases on one cluster (`pg_databases` and user accounts are among the few things shared).
If a clean schema is needed, use the following to create a separate set of sandbox databases:
1. Define a prefix in your shell
  - `export REDSHIFT_SANDBOX_PREFIX=...`
  - Example: `REDSHIFT_SANDBOX_PREFIX=edog` will use `edog_engineering`, `edog_ops`, etc.
2. Create the databases on sandbox
  - `rake db:create_user_sandbox`
3. Run migrations as normal.
  - All sandbox environments will now use the separate prefix databases instead of the defaults.

CREATING A MIGRATION
====================
1. Create your migration file with `RAILS_ENV=sandbox_engineering rails generate migration MIGRATION_NAME_HERE` (exact cluster doesn't matter as long as it exists in database.yml)
2. Move migration file to proper db subdirectory. ```common``` migrations run on engineering and ops clusters. If you need it to run on avails and another cluster, copy it to both.
3. Test it out on sandbox (`rake db:migrate_sandbox` locally will run migrations to both sandbox DBs)
4. Make a PR
5. After the PR gets merged, run the migration on production with `rake db:migrate_production`

RUNNING A MIGRATION
===================
1. Option 1: Single cluster
  - ```rake db:migrate_sandbox_engineering```
  - ```rake db:migrate_sandbox_ops```
  - ```rake db:migrate_production_ops```
  - ```rake db:migrate_production_engineering```
2. Option 2: Multi-cluster
  - ```rake db:migrate_sandbox```
  - ```rake db:migrate_production```

ROLLING BACK A MIGRATION
========================
1. Option 1: Single cluster
  - ```rake db:rollback_sandbox_engineering```
  - ```rake db:rollback_sandbox_ops```
  - ```rake db:rollback_production_ops```
  - ```rake db:rollback_production_engineering```
2. Option 2: Multi-cluster
  - ```rake db:rollback_sandbox```
  - ~~```rake db:rollback_production```~~ Nope, rolling back migrations on multiple prod clusters is dangerous because you could be rolling back two different migrations!

CHECKING WHAT MIGRATIONS HAVE AND HAVEN'T BEEN RUN
==================================================
Single cluster only, because it outputs a list of _all_ the migrations.
- ```rake db:migrate_sandbox_engineering:status```
- ```rake db:migrate_sandbox_ops:status```
- ```rake db:migrate_production_ops:status```
- ```rake db:migrate_production_engineering:status```


GENERATING DOCUMENTATION
========================
1. Download the .jar files for SchemaSpy
  - ```rake schemaspy:download_reqs```
  - Downloads a patched JDBC driver that doesn't query options unsupported by Redshift
  - http://www.garrettpatterson.com/2013/08/13/connect-pentahomondrian-schema-workbench-to-amazon-redshift/
2. Generate the html documentation
  - ```rake schemaspy:sandbox_engineering:generate```
  - (similar commands exist for other clusters)
  - Note: Production and Shared Sandbox dbs tend to gather ad hoc tables.
    See [user-specific sandboxes](user-specific-sandboxes) above.
3. Open the html documentation in browser (OS X only)
  - ```rake schemaspy:sandbox_engineering:open```
  - (similar commands exist for other clusters)


NOTE
====
- Do not chain multiple targets when using these rake tasks!
- Postgres text-unlimited should have a 65K limit string column in redshift