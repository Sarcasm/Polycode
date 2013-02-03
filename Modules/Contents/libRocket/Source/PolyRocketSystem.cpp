#include "PolyRocketSystem.h"

#include "PolyCoreServices.h"
#include "PolyCore.h"

using namespace Polycode;

PolyRocketSystem::PolyRocketSystem()
{ }

PolyRocketSystem::~PolyRocketSystem()
{ }

float PolyRocketSystem::GetElapsedTime()
{
  return static_cast<float>(CoreServices::getInstance()->getCore()->getElapsed());
}
