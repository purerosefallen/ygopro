--高速决斗技能-泥土巨人
Duel.LoadScript("speed_duel_common.lua")
function c100730076.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730076.skill,c100730076.con,aux.Stringid(100730076,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730076.filter1(c)
	return c:IsCode(46986414) and c:IsFaceup()
end
function c100730076.filter2(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup() and c:IsAttackAbove(3000)
end
function c100730076.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730076.filter1,tp,LOCATION_MZONE,0,1,nil)
		and (Duel.GetLP(tp)<=2000
		or Duel.IsExistingMatchingCard(c100730076.filter2,tp,0,LOCATION_MZONE,1,nil))
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c100730076.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730076)
	local token=Duel.CreateToken(tp,43959432)
	Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
	e:Reset()
end
