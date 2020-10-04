--高速决斗技能-寄生虫感染
Duel.LoadScript("speed_duel_common.lua")
function c100730027.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730027.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730027.filter(c,g)
	if not c:IsRace(RACE_INSECT) then return false end
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
function c100730027.skill(e,tp)
	local g=Group.CreateGroup()
	if not Duel.IsExistingMatchingCard(c100730027.filter,tp,LOCATION_DECK+LOCATION_HAND,0,4,nil,g) then
		Duel.Hint(HINT_MESSAGE,tp,aux.Stringid(100730027,0))
		e:Reset()
		return
	end
	tp=e:GetLabelObject():GetOwner()
	local count=1
	if Duel.TossCoin(tp,1)==1 then
		count=2
	end
	while count>0 do
		local parasite=Duel.CreateToken(tp,27911549)
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(parasite,1-tp,2,REASON_RULE)
		parasite:ReverseInDeck()
		count=count-1
	end
	Duel.ShuffleDeck(1-tp)
	e:Reset()
end