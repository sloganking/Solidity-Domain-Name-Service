# Avoiding-Common-Attacks

## Common attacks which measures were taken to prevent
During the creation of this project, multiple measures were taken to ensure that the project's contracts are not susceptible to common attacks.

### Reentrancy attacks

No calls were made to external contracts

### Force Sending Ether

Contract contains no logic that depends on the contract balance. 

### Keeping secrets

Knowing the information in privately declared variables does not give users an unfair advantage.

## Attempts to increase clarity of contract

- Re-used modifiers which reduces code complexity and makes auditing easier.
- Formatting:
  - Put each modifier on seperate line, increasing the readability of each function.

