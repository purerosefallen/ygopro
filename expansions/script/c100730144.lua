--高速决斗技能-未来视界
Duel.LoadScript("speed_duel_common.lua")
function c100730144.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730144.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730144.filter(c,g)
	if not c:IsSetCard(0x31) then return false end
	local tc=g:GetFirst()
	while tc do
		if c:GetOriginalCode()==tc:GetOriginalCode() then
			return false
		end
		tc=g:GetNext()
	end
	g:AddCard(c)
	return true
end
function c100730144.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730144.filter,tp,LOCATION_DECK+LOCATION_HAND,0,5,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730144,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730144)
	local cn=Duel.CreateToken(tp,87902575)
	Duel.MoveToField(cn,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	Duel.PayLPCost(tp,1500)
	e:Reset()
end