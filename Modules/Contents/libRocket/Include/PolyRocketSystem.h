
#pragma once

// XXX: libRocket has a definition for Rocket::Math::PI, a float but
//      Polycode defines (as a define) PI. Try to include libRocket
//      without breaking it's definition of Math::PI.
#ifdef PI
# define PI_BAKCUP PI
# undef PI
#endif

#include "Rocket/Core/SystemInterface.h"

#ifdef PI_BAKCUP
# define PI PI_BAKCUP
#endif

#include "PolyGlobals.h"

namespace Polycode {

class _PolyExport PolyRocketSystem : public Rocket::Core::SystemInterface
{
public:
  PolyRocketSystem();
  ~PolyRocketSystem();
  float GetElapsedTime();
};

}
