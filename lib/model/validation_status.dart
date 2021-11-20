

enum Status { VALID,ERROR,NONE }

class ValidationStatus
{
  // bool isUserNameValid=false;
  // bool isPasswordValid=false;
  // bool isBothValid=false;

  Status passwordStatus=Status.NONE;
  Status usernameStatus=Status.NONE;
  Status bothStatus=Status.NONE;
}