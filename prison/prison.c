#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_LENGTH 100
#define MAX_DETAIL_LENGTH 50
#define FILENAME "jail_details.txt"
#define BINARY_FILENAME "jail_details.dat"
#define LOGIN_FILE "login.txt"

struct prisoner
{
    int id;
    char name[MAX_NAME_LENGTH];
    int age;
    char gender[10];
    char crime[MAX_NAME_LENGTH];
    char conviction[MAX_NAME_LENGTH];
    int sentenceDuration;
    int cellNumber;
    float weight;
    float height;
    char hairColor[MAX_DETAIL_LENGTH];
    char eyeColor[MAX_DETAIL_LENGTH];
    char court[MAX_DETAIL_LENGTH];
    char emergencyContactName[MAX_NAME_LENGTH];
    char emergencyContactRelation[MAX_DETAIL_LENGTH];
    char emergencyContactPhone[MAX_DETAIL_LENGTH];
};
typedef struct prisoner p;

void login();
void displayMenu();
void addRecord();
void searchRecord();
void editRecord();
void deleteRecord();
void viewRecords();
void writeRecordToFile(p *prisoner);
void writeRecordToBinaryFile(p *prisoner);
p *findRecordById(int id);
p *findRecordByIdBinary(int id);

int main() 
{
    login();
    system("clear");
    displayMenu();
    return 0;
}

void login() 
{
    char username[50], password[50];
    char storedUsername[50], storedPassword[50];
    int attempts = 3;

    FILE *file = fopen(LOGIN_FILE, "r");
    if (file == NULL) 
    {
        printf("No login file found. Please contact the administrator.\n");
        exit(0);
    }

    fscanf(file, "%s %s", storedUsername, storedPassword);
    fclose(file);

    while (attempts > 0) 
    {
        system("clear");
        printf("\n\t\tENTER YOUR LOGIN CREDENTIALS\n\n");

        printf("Enter username: ");
        scanf("%s", username);
        printf("Enter password: ");
        scanf("%s", password);

        if (strcmp(username, storedUsername) == 0 && strcmp(password, storedPassword) == 0) 
        {
            printf("Login successful.\n");
            return;
        } 
        else 
        {
            attempts--;
            if (attempts > 0)
            {
                printf("Invalid credentials. You have %d attempt(s) remaining.\n\n", attempts);
            }
        }
    }

    printf("Too many failed attempts. Exiting...\n");
    exit(0);
}

void displayMenu()
{
    int choice;
    printf("\n\t\t WELCOME TO PRISONER RECORD ADMINISTRATION\n\n");
    while (1) 
    {
        printf("\n");
        printf("\n1. Add Record\n");
        printf("2. Search Record\n");
        printf("3. Edit Record\n");
        printf("4. Delete Record\n");
        printf("5. View All Records\n");
        printf("6. Exit\n\n");

        printf("Enter your selection here: ");
        scanf("%d", &choice);

        switch (choice) 
        {
            case 1:
                addRecord();
                break;
            case 2:
                searchRecord();
                break;
            case 3:
                editRecord();
                break;
            case 4:
                deleteRecord();
                break;
            case 5:
                viewRecords();
                break;
            case 6:
                system("clear");
                printf("\n\n\n\t\t Thank you for coming, and do visit again.\n\n");
                exit(0);
            default:
                printf("\nNot a valid option. Kindly give it another attempt.\n\n");
                     
        }
    }
}

// Function to add a record
void addRecord() 
{
    p prisoner;
    system("clear");
    printf("\t\t FEEL FREE TO ADD THE PRISONER INFORMATION\n\n");

    printf("Enter prisoner ID: ");
    scanf("%d", &prisoner.id);
    getchar();

    printf("Enter prisoner name: ");
    fgets(prisoner.name, MAX_NAME_LENGTH, stdin);
    prisoner.name[strcspn(prisoner.name, "\n")] = '\0';

    printf("Enter prisoner age: ");
    scanf("%d", &prisoner.age);
    getchar();

    printf("Enter gender: ");
    fgets(prisoner.gender, sizeof(prisoner.gender), stdin);
    prisoner.gender[strcspn(prisoner.gender, "\n")] = '\0';

    printf("Enter crime: ");
    fgets(prisoner.crime, MAX_NAME_LENGTH, stdin);
    prisoner.crime[strcspn(prisoner.crime, "\n")] = '\0';

    printf("Enter conviction: ");
    fgets(prisoner.conviction, MAX_NAME_LENGTH, stdin);
    prisoner.conviction[strcspn(prisoner.conviction, "\n")] = '\0';

    printf("Enter sentence duration (in months): ");
    scanf("%d", &prisoner.sentenceDuration);
    getchar();

    printf("Enter cell number: ");
    scanf("%d", &prisoner.cellNumber);
    getchar();

    printf("Enter weight (in kg): ");
    scanf("%f", &prisoner.weight);
    getchar();

    printf("Enter height (in cm): ");
    scanf("%f", &prisoner.height);
    getchar();

    printf("Enter hair color: ");
    fgets(prisoner.hairColor, MAX_DETAIL_LENGTH, stdin);
    prisoner.hairColor[strcspn(prisoner.hairColor, "\n")] = '\0';

    printf("Enter eye color: ");
    fgets(prisoner.eyeColor, MAX_DETAIL_LENGTH, stdin);
    prisoner.eyeColor[strcspn(prisoner.eyeColor, "\n")] = '\0';

    printf("Enter court: ");
    fgets(prisoner.court, MAX_DETAIL_LENGTH, stdin);
    prisoner.court[strcspn(prisoner.court, "\n")] = '\0';

    printf("Enter emergency contact name: ");
    fgets(prisoner.emergencyContactName, MAX_NAME_LENGTH, stdin);
    prisoner.emergencyContactName[strcspn(prisoner.emergencyContactName, "\n")] = '\0';

    printf("Enter emergency contact relation: ");
    fgets(prisoner.emergencyContactRelation, MAX_DETAIL_LENGTH, stdin);
    prisoner.emergencyContactRelation[strcspn(prisoner.emergencyContactRelation, "\n")] = '\0';

    printf("Enter emergency contact phone number: ");
    fgets(prisoner.emergencyContactPhone, MAX_DETAIL_LENGTH, stdin);
    prisoner.emergencyContactPhone[strcspn(prisoner.emergencyContactPhone, "\n")] = '\0';

    writeRecordToFile(&prisoner);
    writeRecordToBinaryFile(&prisoner);

    printf("\n\t\t\"Record added successfully.\"\n\n");
}

// Function to write a record to the text file
void writeRecordToFile(p *prisoner) 
{
    FILE *file = fopen(FILENAME, "a");

    if (file == NULL) 
    {
        printf("Unable to open file for writing.\n");
        return;
    }

    fprintf(file, "%d,%s,%d,%s,%s,%s,%d,%d,%.2f,%.2f,%s,%s,%s,%s,%s,%s\n", 
            prisoner->id, 
            prisoner->name, 
            prisoner->age, 
            prisoner->gender, 
            prisoner->crime, 
            prisoner->conviction, 
            prisoner->sentenceDuration, 
            prisoner->cellNumber, 
            prisoner->weight, 
            prisoner->height, 
            prisoner->hairColor, 
            prisoner->eyeColor, 
            prisoner->court, 
            prisoner->emergencyContactName, 
            prisoner->emergencyContactRelation, 
            prisoner->emergencyContactPhone);
    fclose(file);
}

// Function to write a record to the binary file
void writeRecordToBinaryFile(p *prisoner) 
{
    FILE *file = fopen(BINARY_FILENAME, "ab");

    if (file == NULL) 
    {
        printf("Unable to open binary file for writing.\n");
        return;
    }

    fwrite(prisoner, sizeof(p), 1, file);
    fclose(file);
}

// Function to search for a record in the text file
void searchRecord() 
{
    int id;
    p *prisoner;

    system("clear");
    printf("\t\t WELCOME TO SEARCH THE PRISONER RECORD \n\n");

    printf("Enter prisoner ID to search: ");
    scanf("%d", &id);

    prisoner = findRecordById(id);
    if (prisoner != NULL) 
    {
        printf("\nID: %d\nName: %s\nAge: %d\nGender: %s\nCrime: %s\nConviction: %s\nSentence Duration: %d months\nCell Number: %d\nWeight: %.2f kg\nHeight: %.2f cm\nHair Color: %s\nEye Color: %s\nCourt: %s\nEmergency Contact Name: %s\nEmergency Contact Relation: %s\nEmergency Contact Phone: %s\n", 
                prisoner->id, 
                prisoner->name, 
                prisoner->age, 
                prisoner->gender, 
                prisoner->crime, 
                prisoner->conviction, 
                prisoner->sentenceDuration, 
                prisoner->cellNumber, 
                prisoner->weight, 
                prisoner->height, 
                prisoner->hairColor, 
                prisoner->eyeColor, 
                prisoner->court, 
                prisoner->emergencyContactName, 
                prisoner->emergencyContactRelation, 
                prisoner->emergencyContactPhone);
        free(prisoner);
    } 
    else 
    {
        printf("Record not found.\n");
    }
}

// Function to find a record by ID in the text file
p *findRecordById(int id) 
{
    FILE *file = fopen(FILENAME, "r");
    if (file == NULL) 
    {
        printf("Unable to open file for reading.\n");
        return NULL;
    }

    p *prisoner = malloc(sizeof(p));

    while (fscanf(file, "%d,%[^,],%d,%[^,],%[^,],%[^,],%d,%d,%f,%f,%[^,],%[^,],%[^,],%[^,],%[^,],%[^\n]\n", 
                  &prisoner->id, 
                  prisoner->name, 
                  &prisoner->age, 
                  prisoner->gender, 
                  prisoner->crime, 
                  prisoner->conviction, 
                  &prisoner->sentenceDuration, 
                  &prisoner->cellNumber, 
                  &prisoner->weight, 
                  &prisoner->height, 
                  prisoner->hairColor, 
                  prisoner->eyeColor, 
                  prisoner->court, 
                  prisoner->emergencyContactName, 
                  prisoner->emergencyContactRelation, 
                  prisoner->emergencyContactPhone) != EOF) 
    {
        if (prisoner->id == id) 
        {
            fclose(file);
            return prisoner;
        }
    }

    fclose(file);
    free(prisoner);
    return NULL;
}

// Function to search for a record in the binary file
p *findRecordByIdBinary(int id) 
{
    FILE *file = fopen(BINARY_FILENAME, "rb");
    if (file == NULL) 
    {
        printf("Unable to open binary file for reading.\n");
        return NULL;
    }

    p *prisoner = malloc(sizeof(p));

    while (fread(prisoner, sizeof(p), 1, file)) 
    {
        if (prisoner->id == id) 
        {
            fclose(file);
            return prisoner;
        }
    }

    fclose(file);
    free(prisoner);
    return NULL;
}

// Function to edit a record in the binary file
void editRecord() 
{
    int id;
    p *prisoner;
    FILE *file, *tempFile, *textFile, *tempTextFile;

    system("clear");
    printf("\t\t WELCOME TO EDIT THE PRISONER RECORD \n\n");

    printf("Enter prisoner ID to edit: ");
    scanf("%d", &id);

    prisoner = findRecordByIdBinary(id);
    if (prisoner == NULL) 
    {
        printf("Record not found.\n");
        return;
    }

    // Update the binary file
    file = fopen(BINARY_FILENAME, "rb");
    tempFile = fopen("temp.dat", "wb");

    if (file == NULL || tempFile == NULL) 
    {
        printf("Unable to open binary file.\n");
        return;
    }

    p temp;
    while (fread(&temp, sizeof(p), 1, file)) 
    {
        if (temp.id == id) 
        {
            printf("Enter new details for the prisoner:\n");

            printf("Enter prisoner name: ");
            getchar();
            fgets(prisoner->name, MAX_NAME_LENGTH, stdin);
            prisoner->name[strcspn(prisoner->name, "\n")] = '\0';

            printf("Enter prisoner age: ");
            scanf("%d", &prisoner->age);
            getchar();

            printf("Enter gender: ");
            fgets(prisoner->gender, sizeof(prisoner->gender), stdin);
            prisoner->gender[strcspn(prisoner->gender, "\n")] = '\0';

            printf("Enter crime: ");
            fgets(prisoner->crime, MAX_NAME_LENGTH, stdin);
            prisoner->crime[strcspn(prisoner->crime, "\n")] = '\0';

            printf("Enter conviction: ");
            fgets(prisoner->conviction, MAX_NAME_LENGTH, stdin);
            prisoner->conviction[strcspn(prisoner->conviction, "\n")] = '\0';

            printf("Enter sentence duration (in months): ");
            scanf("%d", &prisoner->sentenceDuration);
            getchar();

            printf("Enter cell number: ");
            scanf("%d", &prisoner->cellNumber);
            getchar();

            printf("Enter weight (in kg): ");
            scanf("%f", &prisoner->weight);
            getchar();

            printf("Enter height (in cm): ");
            scanf("%f", &prisoner->height);
            getchar();

            printf("Enter hair color: ");
            fgets(prisoner->hairColor, MAX_DETAIL_LENGTH, stdin);
            prisoner->hairColor[strcspn(prisoner->hairColor, "\n")] = '\0';

            printf("Enter eye color: ");
            fgets(prisoner->eyeColor, MAX_DETAIL_LENGTH, stdin);
            prisoner->eyeColor[strcspn(prisoner->eyeColor, "\n")] = '\0';

            printf("Enter court: ");
            fgets(prisoner->court, MAX_DETAIL_LENGTH, stdin);
            prisoner->court[strcspn(prisoner->court, "\n")] = '\0';

            printf("Enter emergency contact name: ");
            fgets(prisoner->emergencyContactName, MAX_NAME_LENGTH, stdin);
            prisoner->emergencyContactName[strcspn(prisoner->emergencyContactName, "\n")] = '\0';

            printf("Enter emergency contact relation: ");
            fgets(prisoner->emergencyContactRelation, MAX_DETAIL_LENGTH, stdin);
            prisoner->emergencyContactRelation[strcspn(prisoner->emergencyContactRelation, "\n")] = '\0';

            printf("Enter emergency contact phone number: ");
            fgets(prisoner->emergencyContactPhone, MAX_DETAIL_LENGTH, stdin);
            prisoner->emergencyContactPhone[strcspn(prisoner->emergencyContactPhone, "\n")] = '\0';

            fwrite(prisoner, sizeof(p), 1, tempFile);
        }
        else 
        {
            fwrite(&temp, sizeof(p), 1, tempFile);
        }
    }

    fclose(file);
    fclose(tempFile);

    remove(BINARY_FILENAME);
    rename("temp.dat", BINARY_FILENAME);

    // Update the text file
    textFile = fopen(FILENAME, "r");
    tempTextFile = fopen("temp.txt", "w");

    if (textFile == NULL || tempTextFile == NULL) 
    {
        printf("Unable to open text file.\n");
        return;
    }

    char buffer[MAX_NAME_LENGTH * 16];
    while (fgets(buffer, sizeof(buffer), textFile)) 
    {
        int tempId;
        sscanf(buffer, "%d,", &tempId);
        if (tempId == id) 
        {
            fprintf(tempTextFile, "%d,%s,%d,%s,%s,%s,%d,%d,%.2f,%.2f,%s,%s,%s,%s,%s,%s\n", 
                    prisoner->id, 
                    prisoner->name, 
                    prisoner->age, 
                    prisoner->gender, 
                    prisoner->crime, 
                    prisoner->conviction, 
                    prisoner->sentenceDuration, 
                    prisoner->cellNumber, 
                    prisoner->weight, 
                    prisoner->height, 
                    prisoner->hairColor, 
                    prisoner->eyeColor, 
                    prisoner->court, 
                    prisoner->emergencyContactName, 
                    prisoner->emergencyContactRelation, 
                    prisoner->emergencyContactPhone);
        }
        else 
        {
            fputs(buffer, tempTextFile);
        }
    }

    fclose(textFile);
    fclose(tempTextFile);

    remove(FILENAME);
    rename("temp.txt", FILENAME);

    free(prisoner);

    printf("Record updated successfully.\n");
}

// Function to delete a record in the binary file
void deleteRecord() 
{
    int id;
    FILE *file, *tempFile;

    system("clear");
    printf("\t\t WELCOME TO DELETE THE PRISONER RECORD \n\n");

    printf("Enter prisoner ID to delete: ");
    scanf("%d", &id);

    file = fopen(BINARY_FILENAME, "rb");
    tempFile = fopen("temp.dat", "wb");

    if (file == NULL || tempFile == NULL) 
    {
        printf("Unable to open file.\n");
        return;
    }

    p temp;
    int found = 0;
    while (fread(&temp, sizeof(p), 1, file)) 
    {
        if (temp.id == id) 
        {
            found = 1;
            continue;
        }
        fwrite(&temp, sizeof(p), 1, tempFile);
    }

    fclose(file);
    fclose(tempFile);

    remove(BINARY_FILENAME);
    rename("temp.dat", BINARY_FILENAME);

    if (found) 
    {
        printf("Record deleted successfully.\n");
    } 
    else 
    {
        printf("Record not found.\n");
    }
}

// Function to view all records in the binary file
void viewRecords() 
{
    FILE *file = fopen(BINARY_FILENAME, "rb");

    if (file == NULL) 
    {
        printf("Unable to open file.\n");
        return;
    }

    p prisoner;
    system("clear");
    printf("\t\t VIEW ALL PRISONER RECORDS \n\n");

    while (fread(&prisoner, sizeof(p), 1, file)) 
    {
        printf("\nID: %d\nName: %s\nAge: %d\nGender: %s\nCrime: %s\nConviction: %s\nSentence Duration: %d months\nCell Number: %d\nWeight: %.2f kg\nHeight: %.2f cm\nHair Color: %s\nEye Color: %s\nCourt: %s\nEmergency Contact Name: %s\nEmergency Contact Relation: %s\nEmergency Contact Phone: %s\n", 
               prisoner.id, 
               prisoner.name, 
               prisoner.age, 
               prisoner.gender, 
               prisoner.crime, 
               prisoner.conviction, 
               prisoner.sentenceDuration, 
               prisoner.cellNumber, 
               prisoner.weight, 
               prisoner.height, 
               prisoner.hairColor, 
               prisoner.eyeColor, 
               prisoner.court, 
               prisoner.emergencyContactName, 
               prisoner.emergencyContactRelation, 
               prisoner.emergencyContactPhone);
    }

    fclose(file);
}
