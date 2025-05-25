from django.db import models

class Subject(models.Model):
    name = models.CharField(max_length=100)
    height = models.FloatField()
    weight = models.FloatField()
    birthdate = models.DateField()
    haircolor = models.CharField(max_length=50)
    eyecolor = models.CharField(max_length=50)
    class Meta:
        db_table = 'subject'  

class Detective(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'detective'

class Questions(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'questions'

class Answers(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        db_table = 'answers'