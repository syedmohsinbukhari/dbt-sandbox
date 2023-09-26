# DBT Sandbox

- This sandbox uses Google Cloud Big Query.
- Projects directory is going to contain DBT projects.

## Workflow for first go at DBT Sandbox

- Create a DBT project.
- Create a few simple models inside the project.
    - Create a static model inside this project.
    - Make an incremental model inside this project.
- Try out different strategies for building an incremental model.
    - `insert_overwrite`
    - `merge`
