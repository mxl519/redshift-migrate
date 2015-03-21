PROJECT FOR RUNNING REDSHIFT MIGRATIONS

CREATING A MIGRATION
====================
1. Create your migration file with `rails generate migration MIGRATION_NAME_HERE`
2. Move migration file to proper db subdirectory, ```common``` for migrations to be run on both clusters.
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
- ```rake db:migrate_status_sandbox_engineering```
- ```rake db:migrate_status_sandbox_ops```
- ```rake db:migrate_status_production_ops```
- ```rake db:migrate_status_production_engineering```


NOTE
====
Do not chain multiple targets when using these rake tasks!
