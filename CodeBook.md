##The variables used in the final table:

subjects - includes id for each participant in the trial

activities - names of the activity performed by the participant: walking, sitting, standing, etc

measures - name of the particular measurement, e.g - acceleration in  one of the axes (X, Y or Z)

average - of the collection of values of the particular measure, per subject, per activity

## Transformations:
- Merging "train" and "test" data sets
- combining subjects, activities, with the readings. Also assigning headers.
- subsetting according to assignment requirements
- manipulating the header names to be more readable
- setting labels to activities (rather than numbers)
- calculating average of measurements per subject, per activity
- "melting" the table to give one column for all activities