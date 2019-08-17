using HousingXyz.Provider.Lib.Models;
using Xunit;

namespace HousingXyz.Provider.Tests.Units
{
  public class RoomSpec
  {
    [Fact]
    public void Test_Properties()
    {
      var sut = new Room();

      Assert.IsType<string>(sut.Address);
      Assert.IsType<int>(sut.Beds);
      Assert.IsType<string>(sut.Gender);
    }
  }
}
