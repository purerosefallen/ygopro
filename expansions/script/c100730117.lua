--高速决斗技能-被双神选中的男人
Duel.LoadScript("speed_duel_common.lua")
function c100730117.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730117.skill,c100730117.con,aux.Stringid(100730117,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730117.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,41181774)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,39823987)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,66818682)
end
function c100730117.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,1,nil,41181774)
	local c=g:Select(tp,1,1,nil)
	if c then
	   Duel.Hint(HINT_CARD,1-tp,100730117)
	   local d1=Duel.CreateToken(tp,44710391)
	   Duel.MoveToField(d1,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	   local d2=Duel.CreateToken(tp,91468551)
	   Duel.MoveToField(d2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	   local d3=Duel.CreateToken(tp,70109009)
	   Duel.MoveToField(d3,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	   local d4=Duel.CreateToken(tp,25472513)
	   Duel.MoveToField(d4,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	e:Reset()
	end
end