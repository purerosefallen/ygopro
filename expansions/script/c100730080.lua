--高速决斗技能-螺旋枪杀
Duel.LoadScript("speed_duel_common.lua")
function c100730080.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730080.skill,c100730080.con,aux.Stringid(100730080,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730080.filter(c)
	return c:IsSetCard(0xbd) or c:IsCode(66889139) and c:IsFaceup()
end

function c100730080.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730080.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c100730080.skill(e,tp)
	Duel.Hint(HINT_CARD,1-tp,100730080)
	local d=Duel.CreateToken(1-tp,49328340)
	Duel.MoveToField(d,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,34370473)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
end