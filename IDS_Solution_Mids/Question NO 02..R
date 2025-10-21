Emp_ID <- c("E1","E2","E3","E4","E5","E6","E7","E8")
> Name <- c("X","Y","Z","X","Y","Z","X","Y")
> Age <- c(34,29,40,30,35,27,41,30)
> Dept <- c("HR","IT","Finance","Marketing","HR","IT","Finance","Marketing")
> Salary <- c(50000,60000,70000,80000,50000,65000,45000,60000)
> Gender <- c("Male","Female","Male","Female","Male","Female","Male","Female")
> Experience <- c(5,3,10,4,2,7,9,6)
> 
  > employees <- data.frame(Emp_ID, Name, Age, Dept, Salary, Gender, Experience)
  > 
    > # Extract Salary column as a vector
    > salary_vector <- employees$Salary
    > 
      > # Print the salary vector
      > print(salary_vector)
    [1] 50000 60000 70000 80000 50000 65000 45000 60000
    > 
      > # Calculate the average salary
      > average_salary <- mean(salary_vector)
      > 
        > # Print the average salary
        > print(average_salary)
      [1] 60000
      > 
        > Emp_ID <- c("E1","E2","E3","E4","E5","E6","E7","E8")
        > Name <- c("X","Y","Z","X","Y","Z","X","Y")
        > Age <- c(34,29,40,30,35,27,41,30)
        > Dept <- c("HR","IT","Finance","Marketing","HR","IT","Finance","Marketing")
        > Salary <- c(50000,60000,70000,80000,50000,65000,45000,60000)
        > Gender <- c("Male","Female","Male","Female","Male","Female","Male","Female")
        > Experience <- c(5,3,10,4,2,7,9,6)
        > 
          > employees <- data.frame(Emp_ID, Name, Age, Dept, Salary, Gender, Experience)
          > 
            > # Store the ages of employees in a vector
            > age_vector <- employees$Age
            > 
              > # Print the age vector
              > print(age_vector)
            [1] 34 29 40 30 35 27 41 30
            > 
              > # Find the minimum age
              > min_age <- min(age_vector)
              > 
                > # Find the maximum age
                > max_age <- max(age_vector)
                > 
                  > # Print the results
                  > print(min_age)
                [1] 27
                > print(max_age)
                [1] 41
                > 
                  > # Create a list for the first employee
                  > employee1 <- list(
                    +     Name = employees$Name[1],
                    +     Department = employees$Dept[1],
                    +     Age = employees$Age[1],
                    +     Salary = employees$Salary[1]
                    + )
                  > 
                    > # Print the entire list
                    > print(employee1)
                  $Name
                  [1] "X"
                  
                  $Department
                  [1] "HR"
                  
                  $Age
                  [1] 34
                  
                  $Salary
                  [1] 50000
                  
                  > 
                    > # Display each element of the list individually
                    > cat("Name:", employee1$Name, "\n")
                  Name: X 
                  > cat("Department:", employee1$Department, "\n")
                  Department: HR 
                  > cat("Age:", employee1$Age, "\n")
                  Age: 34 
                  > cat("Salary:", employee1$Salary, "\n")
                  Salary: 50000 
                  > 
                    > 