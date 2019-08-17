namespace HousingXyz.Provider.Lib.Models
{
  public class Room
  {
    public string Address { get; set; }
    public int Beds { get; set; }
    public string Gender { get; set; }

    public Room()
    {
      Address = string.Empty;
      Beds = 2;
      Gender = string.Empty;
    }
  }
}
