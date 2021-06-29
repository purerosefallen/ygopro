--高速决斗技能-暗的地平线
Duel.LoadScript("speed_duel_common.lua")
function c100730081.initial_effect(c)
	if not c100730081.UsedLP then
		c100730081.UsedLP={}
		c100730081.UsedLP[0]=0
		c100730081.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelAtMainPhase(c,c100730081.skill,c100730081.con,aux.Stringid(100730081,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730081.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730081)
	c100730081.UsedLP[tp]=c100730081.UsedLP[tp]+2000
	if aux.DecreasedLP[tp]-c100730081.UsedLP[tp]>=2500 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,46986414) then
		local op=Duel.SelectOption(tp,aux.Stringid(100730081,1),aux.Stringid(100730081,2))
		if op==1 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,38033121) then 
			code=38033121
		else code=46986414
		end
	else local d=Duel.CreateToken(tp,38033121)
		Duel.SendtoDeck(d,tp,0,REASON_RULE)
		code=38033121
	end
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_DECK,0,nil,code)
	local c=g:Select(tp,1,1,nil)
	if not c or g:GetCount()==0 then return end
	Duel.SpecialSummon(c,0,tp,tp,true,true,POS_FACEUP)
	e:Reset()
end

function c100730081.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and aux.DecreasedLP[tp]-c100730081.UsedLP[tp] >=2000
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
end